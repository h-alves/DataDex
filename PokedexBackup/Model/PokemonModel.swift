//
//  Pokemon.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 27/09/23.
//

import Foundation

struct PokemonModel: Codable {
    let id: Int
    let name: String
    let sprites: SpritesModel
    let weight: Int
    let height: Int
    let types: [TypesModel]
    let stats: [StatsModel]
}

struct SpritesModel: Codable {
    let front_default: String
    let front_shiny: String
}

struct TypesModel: Codable {
    let slot: Int
    let type: TypeModel
}

struct TypeModel: Codable {
    let name: String
}

struct StatsModel: Codable {
    let base_stat: Int
    let stat: StatModel
}

struct StatModel: Codable {
    let name: String
}
