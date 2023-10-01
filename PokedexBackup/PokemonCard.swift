//
//  PokemonCard.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 27/09/23.
//

import SwiftUI

struct PokemonCard: View {
    var pokemon: PokemonModel
    
    var body: some View {
        HStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                AsyncImage(url: URL(string: pokemon.sprites.front_default)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            
            HStack{
                VStack{
                    Text("\(pokemon.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
//                        .background(.yellow)
                    HStack{
                        let tipo1 = pokemon.types[0].type.name.capitalized
                        
                        Image("\(tipo1)")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        if pokemon.types.count > 1 {
                            let tipo2 = pokemon.types[1].type.name.capitalized
                            Image("\(tipo2)")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.leading, 16)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
//            .background(.blue)
            
            VStack{
                Spacer()
                let numFormatted = String(format: "%03d", pokemon.id)
                Text("\(numFormatted)")
                    .font(.system(size: 48))
                    .fontWeight(.semibold)
            }
            .padding(.trailing, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
//        .background(.red)
        .background(.white)
        .cornerRadius(12)
    }
}

#Preview {
    VStack{
        PokemonCard(pokemon: PokemonModel(id: 2, name: "a", sprites: SpritesModel(front_default: "a", front_shiny: "a"), weight: 1, height: 2, types: [TypesModel(slot: 2, type: TypeModel(name: "a"))], stats: [StatsModel(base_stat: 1, stat: StatModel(name: "a"))]))
    }
    .frame(maxHeight: .infinity)
    .background(Color(UIColor.systemGray4))
}
