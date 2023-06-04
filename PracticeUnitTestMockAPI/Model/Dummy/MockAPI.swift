//
//  MockAPI.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/04.
//

import Foundation

// 参照透過な値を返すAPIModel
struct MockAPI: APIProtocol {
    let session = URLSession.shared

    private let baseURL = "https://pokeapi.co/api/v2"

    var httpError: HTTPError?
    var apiError: APIError?

    let mockPokemonList = PokemonListSampleData().pokemonList
    let mockPokemonDetail = PokemonDetailSampleData().pokemon

    func fetchPokemonList() async throws -> PokemonList {
        // 🍏定数名省略できる!
        if let httpError { throw httpError }
        if let apiError { throw apiError }
        return mockPokemonList
    }

    func fetchPokemonDetail(pokemon: Pokemon) async throws -> PokemonDetail {
        if let httpError { throw httpError }
        if let apiError { throw apiError }
        return mockPokemonDetail
    }
}
