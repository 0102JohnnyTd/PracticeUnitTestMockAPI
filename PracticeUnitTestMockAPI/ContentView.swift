//
//  ContentView.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/01.
//

import SwiftUI

/// ポケモンの一覧を表示するView
struct ContentView: View {
    // データの発生源は外部である為、@ObservedObjectを使う
    @ObservedObject private var pokemonListViewModel: PokemonListViewModel

    init(pokemonListViewModel: PokemonListViewModel) {
        self.pokemonListViewModel = pokemonListViewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                if let pokemonList = pokemonListViewModel.pokemonList {
                    List(pokemonList.results, id: \.name) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            Text(pokemon.name)
                        }
                    }
                    .navigationTitle("Pokemon List")
                } else if let errorMessage = pokemonListViewModel.errorMMessage {
                    Text(errorMessage)
                } else {

                }
            }
            .task {
                await pokemonListViewModel.fetchPokemonList()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pokemonListViewModel: PokemonListViewModel(api: API()))
    }
}
