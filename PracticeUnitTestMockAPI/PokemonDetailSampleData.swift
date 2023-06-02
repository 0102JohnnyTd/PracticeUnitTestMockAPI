//
//  PokemonDetailSampleData.swift
//  PracticeUnitTestMockAPI
//
//  Created by Johnny Toda on 2023/06/02.
//

import Foundation

// Mockに持たせるListのCellをタップ時に遷移する画面に渡す参照透過な値を持つデータクラス
struct PokemonDetailSampleData {
    let pokemon =  PokemonDetail(
        id: 25,
        name: "Pikachu",
        baseExperience: 112,
        height: 4,
        weight: 60,
        types: [
            PokemonType(slot: 1, type: TypeName(name: "Electric"))
        ],
        abilities: [
            Ability(slot: 1, ability: AbilityName(name: "Static"))
        ],
        sprites: Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
    )
}

