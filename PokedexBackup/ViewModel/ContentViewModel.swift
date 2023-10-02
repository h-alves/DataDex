//
//  ContentViewModel.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 29/09/23.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonCompleteModel] = []
    @Published var pokemonCount: Double = 0
    @Published var isLoading: Bool = true
    
    func loadPokemonList() async {
        self.pokemonList = []
        
        Task {
            isLoading = true
            
            for id in 1...905 {
                do {
                    let pokemonComplete = try await PokemonService.shared.getPokemonCompleteById(id: "\(id)")
                    self.pokemonList.append(pokemonComplete)
                } catch {
                    print("Erro ao buscar o Pokémon com o ID \(id): \(error.localizedDescription)")
                }
            }
            self.pokemonList.sort { $0.pokemon.id < $1.pokemon.id }
            
            isLoading = false
        }
    }
}
