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
//                    VStack(alignment: .leading) {
//                        Text("Pokédex")
//                            .font(.system(size: 32))
//                            .fontWeight(.bold)
//                            .foregroundStyle(.red)
//                        
//                       SearchBar(searchText: $searchText, isFocused: $isFocused)
//                    }
//                    .padding(12)
//                    
//                    Spacer()
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
                                ForEach(viewModel.pokemonList, id: \.id) { pokemon in
                                    PokemonCard(pokemon: pokemon)
                                        .padding(.horizontal, 12)
                                }
                            } else {
                                ForEach(viewModel.pokemonList.filter({ pokemon in
                                    pokemon.name.lowercased().contains(searchText.lowercased()) ||
                                    pokemon.id.description == searchText.lowercased()
                                }), id: \.id) { pokemon in
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
