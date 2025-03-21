//
//  PokemonView.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import Kingfisher

struct PokemonView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{Spacer()}
                if let spriteURL = pokemon.sprites?.front_default, let url = URL(string: spriteURL) {
                    KFImage(url)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .padding()
                
                Text("ID: \(pokemon.id)")
                    .font(.subheadline)
                    .padding()
                
                if let types = pokemon.types, !types.isEmpty {
                    Text("Types:")
                        .font(.headline)
                        .padding(.top)
                    ForEach(types, id: \.type.name) { type in
                        Text(type.type.name.capitalized)
                            .font(.body)
                    }
                }
                
                if let abilities = pokemon.abilities, !abilities.isEmpty {
                    Text("Abilities:")
                        .font(.headline)
                        .padding(.top)
                    ForEach(abilities, id: \.ability.name) { ability in
                        Text(ability.ability.name.capitalized)
                            .font(.body)
                    }
                }
                
                if let stats = pokemon.stats, !stats.isEmpty {
                    Text("Stats:")
                        .font(.headline)
                        .padding(.top)
                    ForEach(stats, id: \.stat.name) { stat in
                        Text("\(stat.stat.name.capitalized): \(stat.base_stat)")
                            .font(.body)
                    }
                }
                
                VStack {
                    if let height = pokemon.height {
                        Text("Height: \(height) decimeters")
                            .font(.body)
                    }
                    if let weight = pokemon.weight {
                        Text("Weight: \(weight) hectograms")
                            .font(.body)
                    }
                    Spacer()
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

