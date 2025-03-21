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
        ZStack{
            
            Image("pokBg")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 5, opaque: .random(in: 0...1) > 0.5)
            
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
                        .bold()
                        .shadow(radius: 5)
                        .padding()
                    
                    
                    
                    HStack(spacing:15){
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                if let types = pokemon.types, !types.isEmpty {
                                    Text("Types:")
                                        .font(.headline)
                                    ForEach(types, id: \.type.name) { type in
                                        Text(type.type.name.capitalized)
                                            .font(.body)
                                    }
                                }
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        .frame(height: 150)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.thinMaterial))
                        
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                if let abilities = pokemon.abilities, !abilities.isEmpty {
                                    Text("Abilities:")
                                        .font(.headline)
                                    ForEach(abilities, id: \.ability.name) { ability in
                                        Text(ability.ability.name.capitalized)
                                            .font(.body)
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .frame(height: 150)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.thinMaterial))
                    }
                    
                    HStack{
                        Spacer()
                        VStack{
                            
                            if let stats = pokemon.stats, !stats.isEmpty {
                                Text("Stats:")
                                    .font(.headline)
                                ForEach(stats, id: \.stat.name) { stat in
                                    Text("\(stat.stat.name.capitalized): \(stat.base_stat)")
                                        .font(.body)
                                }
                            }
                        }
                        .padding(.vertical)
                        Spacer()
                    }
                        .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.thinMaterial))
                    
                    HStack{
                        Spacer()
                        VStack {
                            if let height = pokemon.height {
                                Text("Height: \(height) decimeters")
                                    .font(.body)
                            }
                            if let weight = pokemon.weight {
                                Text("Weight: \(weight) hectograms")
                                    .font(.body)
                            }
                        }
                        .padding(.vertical)
                        Spacer()
                    } .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.thinMaterial))
                }
                .padding()
            }
            .navigationTitle(pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

