//
//  PokemonListViewModel.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/05.
//

import Foundation

/// 起動画面のドメインロジックを管理するViewModel
final class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: PokemonList?
    @Published var errorMMessage: String?

    /// 差し替えを容易にする為,APIModel本体ではなく、Protocol型を指定
    private let api: APIProtocol

    init(api: APIProtocol = MockAPI()) {
        self.api = api
    }

    ///  通信して値を取得して加工し、データバインディングしているpokemonListに渡す
    func fetchPokemonList() {
        Task {
            do {
                let list = try await api.fetchPokemonList()
                await setUpPokemonList(pokemonList: list)
                // 🍎localizedDescriptionをユーザーに表示させる意味を感じない。例えば通信エラーなら『通信環境を確認してください』とか表示させたい
            } catch let error as HTTPError {
                await setErrorMessage(errorMessage: error.localizedDescription)
            } catch let error as APIError {
                await setErrorMessage(errorMessage: error.localizedDescription)
            } catch {
                await setErrorMessage(errorMessage: "An unkwon error occurred.")
            }
        }
    }

    /// メインスレッド上で取得して加工した値をデータバインディングしているpokemonListに渡す
    @MainActor private func setUpPokemonList(pokemonList: PokemonList) {
        self.pokemonList = pokemonList
    }

    /// メインスレッド上で取得したエラーの値をデータバインディングしているerrorMessageに渡す
    @MainActor private func setErrorMessage(errorMessage: String) {
        self.errorMMessage = errorMessage
    }
}
