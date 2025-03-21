//
//  PokemonViewModel.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import Foundation
import Alamofire
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = [] 
    @Published var allPokemonNames: [PokemonItem] = []
    @Published var isLoading: Bool = false
    @Published var searchTerm: String = ""

    private var cancellables = Set<AnyCancellable>()
    private var nextPageUrl: String? = "https://pokeapi.co/api/v2/pokemon?limit=10"
    
    var filteredPokemons: [Pokemon] {
        if searchTerm.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
        }
    }


    func fetchAllPokemonNames() {
        guard !isLoading else { return }
        isLoading = true
        
        let url = "https://pokeapi.co/api/v2/pokemon?limit=10000" 
        
        AF.request(url)
            .validate()
            .responseDecodable(of: PokemonResponse.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    self?.allPokemonNames = data.results
                case .failure(let error):
                    print("Error fetching all Pokémon names: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
    }

    
    func fetchPokemons() {
        guard !isLoading else { return }
        isLoading = true
        
        guard let url = nextPageUrl else { return }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: PokemonResponse.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    self?.fetchPokemonDetails(from: data.results)
                    self?.nextPageUrl = data.next
                case .failure(let error):
                    print("Error fetching Pokémon list: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
    }

    func fetchPokemonDetails(from items: [PokemonItem]) {
        let dispatchGroup = DispatchGroup()
        var fetchedPokemons: [Pokemon] = []
        
        for item in items {
            dispatchGroup.enter()
            
            AF.request(item.url)
                .validate()
                .responseDecodable(of: Pokemon.self) { response in
                    switch response.result {
                    case .success(let pokemon):
                        fetchedPokemons.append(pokemon)
                    case .failure(let error):
                        print("Error fetching details for \(item.name): \(error.localizedDescription)")
                    }
                    dispatchGroup.leave()
                }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.pokemons.append(contentsOf: fetchedPokemons)
        }
    }
}
