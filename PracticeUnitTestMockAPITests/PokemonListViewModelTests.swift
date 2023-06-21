//
//  PokemonListViewModelTests.swift
//  PracticeUnitTestMockAPITests
//
//  Created by Johnny Toda on 2023/06/08.
//

import XCTest
import Combine
@testable import PracticeUnitTestMockAPI

final class PokemonListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    // 取得したポケモンデータのテスト
    func testPokemonList() async throws {
        let expectation = expectation(description: "pokemonList")
        let viewModel = PokemonListViewModel(api: MockAPI())
        
        viewModel.$pokemonList
            .dropFirst()
            .prefix(1)
            .sink { pokemonList in
                XCTAssertEqual(pokemonList?.results[18].name, "rattata")
                XCTAssertEqual(pokemonList?.results[18].url, "https://pokeapi.co/api/v2/pokemon/19/")
                
                expectation.fulfill()
            }.store(in: &cancellables)
        // 参照透過なポケモンデータが返る
        viewModel.fetchPokemonList()
        
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    // 通信エラー時のテスト
    @MainActor
    func testCheckHttpErrorMessage() async throws {
        let expectation = expectation(description: "errorMessage")
        
        // 通信環境なしで通信を実行した場合に発生するエラーを固定値として返すViewModelを生成
        let viewModel = PokemonListViewModel(api: MockAPI(httpError: .noNetwork))
        
        viewModel.$errorMessage
            .dropFirst()
            .prefix(1)
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "DEBUG (noNetwork): A network connection could not be established.")
                expectation.fulfill()
            }.store(in: &cancellables)
        
        viewModel.fetchPokemonList()
        
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    // パース失敗時のテスト
    @MainActor
    func testCheckAPIErrorMessage() async throws {
        let expectation = expectation(description: "errorMessage")
        // 🍏引数apiの型をprotocolにすることで指定するクラス/構造体の差し替えを容易にしている！
        // Decode失敗時の参照透過な値を返すMockを初期値にしたViewModelを生成
        let viewModel = PokemonListViewModel(api: MockAPI(apiError: .decodingFailed))
        viewModel.$errorMessage
            .dropFirst()
            .prefix(1)
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "デコードに失敗しました")
                expectation.fulfill()
            }.store(in: &cancellables)
        
        // 実際に通信は行わないが、仮想通信処理を実行
        viewModel.fetchPokemonList()
        
        await fulfillment(of: [expectation], timeout: 3)
    }
}
