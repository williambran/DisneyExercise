//
//  HomeRepository.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchCharacters() async throws -> [CharacterModel]
    func fetchCharacterFav() -> [CharacterModel]
    func saveCharacters(_ characters: [CharacterModel])
    func saveFavoriteCharacter(_ character: CharacterModel)
    
    var configService: CharactersServiceProtocol? {get set}
    var configLocal: LocalManagerProtocol? {get set}


}

class HomeRepository: HomeRepositoryProtocol {
    func saveFavoriteCharacter(_ character: CharacterModel) {
        
    }
    

    
    
    
    

    

    var configLocal:  LocalManagerProtocol?
    var configService: CharactersServiceProtocol?
    
    init(configService: CharactersServiceProtocol?, configLocal: LocalManagerProtocol? = nil) {
        self.configService = configService
        self.configLocal = configLocal
    }
    
    func fetchCharacters() async throws -> [CharacterModel] {
        guard let configService = configService else {
            return fetchCharacterFav() }
        
        do {
            let modelCaharcters = try await  configService.fetch().data
            saveCharacters(modelCaharcters)
            return modelCaharcters
        } catch {
            return fetchCharacterFav()
        }
        
    }

    func fetchCharacterFav() -> [CharacterModel] {
        configLocal?.getCharacters() ?? []
    }
    
    func saveCharacters(_ characters: [CharacterModel]) {
        configLocal?.saveCharacters(characters)
    }
    
}
