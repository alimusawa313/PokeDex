//
//  HomeTab.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import Kingfisher
import Network

struct HomeTab: View {
    @StateObject private var viewModel = PokemonViewModel()
    @EnvironmentObject var router: Router
    @State private var isOffline = false
    private let monitor = NWPathMonitor()
    
    var body: some View {
        NavigationView {
            List {
                if isOffline && viewModel.pokemons.isEmpty {
                    offlineView
                } else if viewModel.searchTerm.isEmpty {
                    pokemonList
                    loadingIndicator
                } else {
                    searchResultsList
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Pokémon List")
            .onAppear {
                checkInternetConnection()
                if !isOffline && viewModel.pokemons.isEmpty {
                    viewModel.fetchPokemons()
                }
            }
            .alert("No Internet Connection", isPresented: $isOffline) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You are offline. Showing cached Pokémon.")
            }
        }
    }
    
    private var pokemonList: some View {
        ForEach(viewModel.pokemons) { pokemon in
            PokemonRow(pokemon: pokemon)
                .onTapGesture {
                    router.navigate(to: .pokemon(pokemon))
                }
                .onAppear {
                    if !isOffline, pokemon == viewModel.pokemons.last {
                        viewModel.fetchPokemons()
                    }
                }
        }
    }

    private var searchResultsList: some View {
        ForEach(viewModel.filteredPokemons) { pokemon in
            PokemonRow(pokemon: pokemon)
                .onTapGesture {
                    router.navigate(to: .pokemon(pokemon))
                }
        }
    }
    
    private var loadingIndicator: some View {
        Group {
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
    }


    private var offlineView: some View {
        HStack {
            Spacer()
            Text("You're offline. Connect to the internet to update Pokémon.")
                .foregroundColor(.gray)
                .italic()
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }

    private func checkInternetConnection() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                isOffline = path.status != .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            KFImage.url(URL(string: pokemon.sprites?.front_default ?? ""))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(pokemon.name.capitalized)
                .font(.headline)
            Spacer()
        }
    }
}

#Preview {
    HomeTab()
}
