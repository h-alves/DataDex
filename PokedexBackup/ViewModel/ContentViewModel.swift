//
//  ContentViewModel.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 29/09/23.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonModel] = []
    @Published var pokemonCount: Double = 0
    @Published var isLoading: Bool = true
    
    func loadPokemonList() async {
        self.pokemonList = []
        
        Task {
            isLoading = true
            
            for id in 1...905 {
                do {
                    let pokemon = try await PokemonService.shared.getById(id: "\(id)")
                    self.pokemonList.append(pokemon)
                } catch {
                    print("Erro ao buscar o Pokémon com o ID \(id): \(error.localizedDescription)")
                }
            }
            self.pokemonList.sort { $0.id < $1.id }
            
            isLoading = false
        }
    }
}
