//
//  PokemonImageView.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/08.
//

import SwiftUI
/// PokemonDetailViewに表示させる画像
struct PokemonImageView: View {
    // AsyncImageに渡す画像URL
    var imageURL: URL?

    var body: some View {
        VStack{
            if let imageURL = imageURL {
                // URLから取得した画像
                AsyncImage(url: imageURL) {
                    phase in
                    switch phase {
                    case .empty:
                        ProgressView("Loading...")
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        fatalError("unExpected Error")
                    }
                }
            } else {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView()
    }
}
