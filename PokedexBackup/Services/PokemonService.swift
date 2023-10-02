//
//  PokemonService.swift
//  PokedexBackup
//
//  Created by Henrique Semmer on 29/09/23.
//

import Foundation

class PokemonService {
    static var shared = PokemonService()
    
    func getPokemonCompleteById(id: String) async throws -> PokemonCompleteModel {
        if let pokemonComplete = getPokemonCompleteUserDefault(id: id) {
            return pokemonComplete
        }
        
        print("API: \(id)")
        let pokemon = try await getById(id: id)
        let species = try await getSpeciesByURL(id: id, url: pokemon.species.url)
        
        let pokemonComplete = PokemonCompleteModel(pokemon: pokemon, species: species)
        
        savePokemonCompleteUserDefault(pokemon: pokemonComplete)
        
        return pokemonComplete
    }
    
    func getById(id: String) async throws -> PokemonModel {
        let pokemon = try await fetchPokemonAPI(id: id)
        
        return pokemon
    }
    
    func fetchPokemonAPI(id: String) async throws -> PokemonModel {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let fetchedPokemon = try JSONDecoder().decode(PokemonModel.self, from: data)
        
        return fetchedPokemon
    }
    
    func getSpeciesByURL(id: String,url: String) async throws -> PokemonSpeciesModel {
        let species = try await fetchSpeciesAPI(url: url)
        
        return species
    }
    
    func fetchSpeciesAPI(url: String) async throws -> PokemonSpeciesModel {
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        
        let fetchedSpecies = try JSONDecoder().decode(PokemonSpeciesModel.self, from: data)
        
        return fetchedSpecies
    }
    
    func savePokemonCompleteUserDefault(pokemon: PokemonCompleteModel) {
        if let encoded = try? JSONEncoder().encode(pokemon) {
            UserDefaults.standard.set(encoded, forKey: pokemon.pokemon.id.description)
        }
    }
        
    func getPokemonCompleteUserDefault(id: String) -> PokemonCompleteModel? {
        if let savedData = UserDefaults.standard.data(forKey: id),
           let decodedPokemon = try? JSONDecoder().decode(PokemonCompleteModel.self, from: savedData) {
            return decodedPokemon
        }
        
        return nil
    }

}
