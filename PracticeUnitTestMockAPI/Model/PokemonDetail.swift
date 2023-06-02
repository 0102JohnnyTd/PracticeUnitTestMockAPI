//
//  PokemonDetail.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/01.
//

import Foundation

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let abilities: [Ability]
    let sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case weight
        case types
        case abilities
        case sprites
    }
}

struct PokemonType: Decodable {
    let slot: Int
    let type: TypeName
}

struct TypeName: Decodable {
    let name: String
}

struct Ability: Decodable {
    let slot: Int
    let ability: AbilityName
}

struct AbilityName: Decodable {
    let name: String
}

struct Sprites: Decodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
