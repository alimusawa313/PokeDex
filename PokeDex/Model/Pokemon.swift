//
//  Pokemon.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import Foundation

struct Pokemon: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let sprites: Sprites?
    let types: [TypeElement]?
    let height: Int?
    let weight: Int?
    let abilities: [Ability]?
    let stats: [Stat]?

    struct Sprites: Codable {
        let front_default: String
    }

    struct TypeElement: Codable {
        let type: TypeInfo
    }

    struct TypeInfo: Codable {
        let name: String
    }

    struct Ability: Codable {
        let ability: AbilityInfo
    }

    struct AbilityInfo: Codable {
        let name: String
    }

    struct Stat: Codable {
        let stat: StatInfo
        let base_stat: Int
    }

    struct StatInfo: Codable {
        let name: String
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PokemonResponse: Codable {
    let results: [PokemonItem]
    let next: String?
}

struct PokemonItem: Codable, Identifiable {
    let name: String
    let url: String
    
    var id: String { name }
}
