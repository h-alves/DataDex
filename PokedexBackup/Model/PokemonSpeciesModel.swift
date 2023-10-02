//
//  PokemonSpeciesModel.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 01/10/23.
//

import Foundation

struct PokemonSpeciesModel: Codable {
    let id: Int
    let names: [NameModel]
}

struct NameModel: Codable {
    let name: String
}
