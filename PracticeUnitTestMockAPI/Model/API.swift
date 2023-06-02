//
//  API.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/02.
//

import Foundation

struct API: PokemonAPIProtocol {
    let session = URLSession.shared

    private let baseUrl = "https://pokeapi.co/api/v2"

    // 1000件取得している。
    func fetchPokemonList() async throws -> PokemonList {
        guard let url = URL(string: "\(baseUrl)/pokemon/?offset=0&limit=1000") else {
            throw APIError.invalidURL
        }
        do {
            let data = try await session.startData(url)
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(PokemonList.self, from: data)
            return pokemon
        } catch _ as DecodingError {
            throw APIError.decodingFailed
        }
    }

    func fetchPokemonDetail(pokemon: Pokemon) async throws -> PokemonDetail {
        guard let url = URL(string: pokemon.url) else {
            throw APIError.invalidURL
        }

        do {
            let data = try await session.startData(url)
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(PokemonDetail.self, from: data)
            return pokemon
        } catch  _ as DecodingError {
            throw APIError.decodingFailed
        }
    }
}

protocol PokemonAPIProtocol {
    func fetchPokemonList() async throws -> PokemonList
    func fetchPokemonDetail(pokemon: Pokemon) async throws -> PokemonDetail
}
