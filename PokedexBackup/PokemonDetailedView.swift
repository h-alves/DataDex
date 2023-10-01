//
//  PokemonDetailedView.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 28/09/23.
//

import SwiftUI

struct PokemonDetailedView: View {
    var pokemon: PokemonModel
    
    var body: some View {
        Text(pokemon.name)
    }
}

#Preview {
    PokemonDetailedView(pokemon: PokemonModel(id: 2, name: "a", sprites: SpritesModel(front_default: "a", front_shiny: "a"), weight: 1, height: 2, types: [TypesModel(slot: 2, type: TypeModel(name: "a"))], stats: [StatsModel(base_stat: 1, stat: StatModel(name: "a"))]))
}
