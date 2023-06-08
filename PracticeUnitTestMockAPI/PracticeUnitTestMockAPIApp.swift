//
//  PracticeUnitTestMockAPIApp.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/01.
//

import SwiftUI

@main
struct PracticeUnitTestMockAPIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(pokemonListViewModel: PokemonListViewModel(api: MockAPI(apiError: .decodingFailed)))
        }
    }
}
