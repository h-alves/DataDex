//
//  PokemonDetailedView.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 28/09/23.
//

import SwiftUI

struct PokemonDetailedView: View {
    var pokemon: PokemonCompleteModel
    
    var body: some View {
        VStack {
            // Título
            VStack(spacing: 4) {
                HStack {
                    Text("\(pokemon.species.names[6].name)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    let numFormatted = String(format: "%03d", pokemon.pokemon.id)
                    Text("#\(numFormatted)")
                }
                
                HStack{
                    let tipo1 = pokemon.pokemon.types[0].type.name.capitalized
                    
                    Image("\(tipo1)")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    if pokemon.pokemon.types.count > 1 {
                        let tipo2 = pokemon.pokemon.types[1].type.name.capitalized
                        Image("\(tipo2)")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                }
            }
            
            // Imagens
            HStack {
                VStack {
                    AsyncImage(url: URL(string: pokemon.pokemon.sprites.front_default)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 180, height: 180)
                    
                    Text("Normal")
                }
                
                VStack {
                    AsyncImage(url: URL(string: pokemon.pokemon.sprites.front_shiny)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 180, height: 180)
                    
                    Text("Shiny")
                }
            }
            .padding(.bottom, 24)
            
            // Stats
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .padding(-8)
                        .foregroundStyle(Color.white)
                        .frame(maxHeight: 200)
                    
                    VStack {
                        ForEach(pokemon.pokemon.stats, id: \.stat.name) { stat in
                            HStack {
                                Text("\(stat.stat.name):")
                                
                                Spacer()
                                
                                Text("\(stat.base_stat)")
                                
                                let value: Double = Double(stat.base_stat)
                                
                                ProgressView(value: value, total: 255)
                                    .tint(.orange)
                                    .scaleEffect(3, anchor: .leading)
                                    .frame(maxWidth: 50)
                                    .padding(.trailing, 100)
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(24)
        .background(Color(UIColor.systemGray6))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PokemonDetailedView(pokemon: PokemonCompleteModel(pokemon: PokemonModel(id: 2, name: "a", sprites: SpritesModel(front_default: "a", front_shiny: "a"), weight: 1, height: 2, types: [TypesModel(slot: 2, type: TypeModel(name: "a"))], stats: [StatsModel(base_stat: 1, stat: StatModel(name: "a"))], species: SpeciesModel(url: "a")), species: PokemonSpeciesModel(id: 2, names: [NameModel(name: "a")])))
}
