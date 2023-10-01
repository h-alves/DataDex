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
            
            for id in 1...1000 {
                do {
                    let pokemon = try await PokemonService.shared.getById(id: "\(id)")
                    self.pokemonList.append(pokemon)
                    
//                    DispatchQueue.main.async {
//                        self.pokemonCount += 1
//                    }
                } catch {
                    print("Erro ao buscar o Pokémon com o ID \(id): \(error.localizedDescription)")
                }
            }
            self.pokemonList.sort { $0.id < $1.id }
            
            isLoading = false
        }
    }
}
