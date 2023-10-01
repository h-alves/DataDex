//
//  ContentView.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text("Pokédex")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                    
                    // SearchBar
                }
                .padding(12)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            
            if viewModel.isLoading {
                Spacer()
                
                ProgressView()
                
                Spacer()
            }else{
                ScrollView{
                    VStack {
                        // ForEach de componentes
                        ForEach(viewModel.pokemonList, id: \.id) { pokemon in
                            PokemonCard(pokemon: pokemon)
                                .padding(.horizontal, 12)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear{
            Task {
                await viewModel.loadPokemonList()
            }
        }
        .background(Color(UIColor.systemGray4))
    }
}

#Preview {
    ContentView()
}
