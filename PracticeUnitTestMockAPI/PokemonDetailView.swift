//
//  PokemonDetailView.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/08.
//

import SwiftUI

/// ポケモンの詳細を表示するView
struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State var pokemonDetail: PokemonDetail?
    @State var errorText: String?
    let api = API()

    var body: some View {
        VStack {
            if let pokemonDetail = pokemonDetail {
                PokemonImageView(imageURL: URL(string: pokemonDetail.sprites.frontDefault ?? ""))
                Text("Name: \(pokemonDetail.name)")
                Text("Height: \(pokemonDetail.height)")
                Text("Weight: \(pokemonDetail.weight)")
            } else if let errorText {
                Text(errorText)
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            do {
                pokemonDetail = try await api.fetchPokemonDetail(pokemon: pokemon)
            } catch {
                errorText = error.localizedDescription
            }
        }
        .navigationTitle("Pokemon Detail")
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon(name: "", url: ""))
    }
}
