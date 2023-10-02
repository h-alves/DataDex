//
//  ContentView.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var searchText = ""
    @State private var isFocused = false
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
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
                            if searchText == "" {
                                ForEach(viewModel.pokemonList, id: \.pokemon.id) { pokemon in
                                    PokemonCard(pokemon: pokemon)
                                        .padding(.horizontal, 12)
                                }
                            } else {
                                ForEach(viewModel.pokemonList.filter({ pokemon in
                                    pokemon.species.names[6].name.lowercased().contains(searchText.lowercased()) ||
                                    pokemon.pokemon.id.description == searchText.lowercased()
                                }), id: \.pokemon.id) { pokemon in
                                    PokemonCard(pokemon: pokemon)
                                        .padding(.horizontal, 12)
                                }
                            }
                        }
                        .searchable(text: $searchText)
                        .navigationTitle("Pokédex")
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                }
            }
            .onAppear{
                Task {
                    await viewModel.loadPokemonList()
                }
            }
            .background(Color(UIColor.systemGray5))
        }
    }
}

#Preview {
    ContentView()
}
