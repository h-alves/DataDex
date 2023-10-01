//
//  PokemonService.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 29/09/23.
//

import Foundation

class PokemonService {
    static var shared = PokemonService()
    
    func getById(id: String) async throws -> PokemonModel {
        if let pokemon = getPokemonUserDefault(id: id) {
            return pokemon
        }
        print("API: \(id)")
        let pokemon = try await fetchPokemonAPI(id: id)
        
        savePokemonUserDefault(pokemon: pokemon)
        
        return pokemon
    }
    
    func fetchPokemonAPI(id: String) async throws -> PokemonModel {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let fetchedPokemon = try JSONDecoder().decode(PokemonModel.self, from: data)
        
        return fetchedPokemon
    }
    
    func savePokemonUserDefault(pokemon: PokemonModel) {
        if let encoded = try? JSONEncoder().encode(pokemon) {
            UserDefaults.standard.set(encoded, forKey: pokemon.id.description)
        }
    }
        
    func getPokemonUserDefault(id: String) -> PokemonModel? {
        if let savedData = UserDefaults.standard.data(forKey: id),
           let decodedPokemon = try? JSONDecoder().decode(PokemonModel.self, from: savedData) {
            return decodedPokemon
        }
        
        return nil
    }

}
