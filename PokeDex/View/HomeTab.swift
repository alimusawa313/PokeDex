//
//  HomeTab.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import Kingfisher

struct HomeTab: View {
    @StateObject private var viewModel = PokemonViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.searchTerm.isEmpty {
                    pokemonList
                    loadingIndicator
                } else {
                    searchResultsList
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Pokémon List")
            .onAppear {
                if viewModel.pokemons.isEmpty {
                    viewModel.fetchPokemons()
                }
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
                    if pokemon == viewModel.pokemons.last {
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
                .padding()
            }
        }
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
