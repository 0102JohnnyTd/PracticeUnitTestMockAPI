//
//   pokemonDetailViewModel.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/07.
//

import Foundation

/// 遷移先の画面のドメインロジックを管理するViewModelの作成
final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    @Published var errorMessage: String = ""

    /// 差し替えを容易にする為,APIModel本体ではなく、Protocol型を指定
    private let api: APIProtocol

    init(api: APIProtocol = MockAPI()) {
        self.api = api
    }

    ///  通信して値を取得して加工し、データバインディングしているpokemonDetailに渡す
    func fetchPokemonDetail(pokemon: Pokemon) async {
        do {
            let detail = try await api.fetchPokemonDetail(pokemon: pokemon)
            pokemonDetail = detail
        } catch let error as HTTPError {
            errorMessage = error.localizedDescription
        } catch let error as APIError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "An unknown error occurred."
        }
    }
}
