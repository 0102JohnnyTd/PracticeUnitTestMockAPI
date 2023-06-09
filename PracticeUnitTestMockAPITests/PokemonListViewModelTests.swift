//
//  PokemonListViewModelTests.swift
//  PracticeUnitTestMockAPITests
//
//  Created by Johnny Toda on 2023/06/08.
//

import XCTest
@testable import PracticeUnitTestMockAPI

final class PokemonListViewModelTests: XCTestCase {
    // パース失敗時のテスト
    @MainActor
    func testCheckAPIErrorMessage() async throws {
        // 🍏引数apiの型をprotocolにすることで指定するクラス/構造体の差し替えを容易にしている！
        // Decode失敗時の参照透過な値を返すMockを初期値にしたViewModelを生成
        let viewModel = PokemonListViewModel(api: MockAPI(apiError: .decodingFailed))
        // 実際に通信は行わないが、仮想通信処理を実行
        await viewModel.fetchPokemonList()
        XCTContext.runActivity(named: "APIErrorに関して") { _ in
            XCTContext.runActivity(named: ".decodingFailedが生じた場合") { _ in
                XCTAssertEqual(viewModel.errorMMessage, "デコードに失敗しました")
            }
        }
    }
}



