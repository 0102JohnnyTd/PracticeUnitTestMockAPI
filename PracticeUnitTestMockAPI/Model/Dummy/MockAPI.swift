//
//  MockAPI.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/04.
//

import Foundation

// 参照透過な値を返すAPIModel
struct MockPokemonAPI : APIProtocol {
    let session = URLSession.shared

    private let baseUrl = "https://pokeapi.co/api/v2"

    var returnHTTPError: HTTPError?

    var returnPokemonAPIError: APIError?

    let returnMockPokemonList = PokemonListSampleData().pokemonList

    let returnMockPokemonDetail = PokemonDetailSampleData().pokemon


    func fetchPokemonList() async throws -> PokemonList {
        if let returnHTTPError {  throw returnHTTPError }
        if let returnPokemonAPIError { throw returnPokemonAPIError }
        return returnMockPokemonList
    }

    func fetchPokemonDetail(pokemon: Pokemon) async throws -> PokemonDetail {
        if let returnHTTPError {  throw returnHTTPError }
        if let returnPokemonAPIError { throw returnPokemonAPIError }
        return returnMockPokemonDetail
    }
}
