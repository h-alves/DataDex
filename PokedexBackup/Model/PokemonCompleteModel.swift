//
//  PokemonCompleteModel.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 01/10/23.
//

import Foundation

struct PokemonCompleteModel: Codable {
    let pokemon: PokemonModel
    let species: PokemonSpeciesModel
    
    static var emptyPokemon = PokemonCompleteModel(pokemon: PokemonModel(id: 0, name: "", sprites: SpritesModel(front_default: "", front_shiny: ""), weight: 0, height: 0, types: [TypesModel(slot: 0, type: TypeModel(name: ""))], stats: [StatsModel(base_stat: 0, stat: StatModel(name: ""))], species: SpeciesModel(url: "")), species: PokemonSpeciesModel(id: 0, names: [NameModel(name: "")]))
}
