//
//  PokemonList.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/01.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}
