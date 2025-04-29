//
//  LocalManager.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/28/25.
//

import Foundation

protocol LocalManagerProtocol{
    func saveCharacters(_ characters: [CharacterModel])
    func getCharacters() -> [CharacterModel]

}
class LocalManager:  LocalManagerProtocol{
    
    private let userDefaults = UserDefaults.standard
    private let charactersKey = "savedCharacters"
    
    func saveCharacters(_ characters: [CharacterModel]) {
        var combinedCharacters = getCharacters()
        
        for character in characters {
            if !combinedCharacters.contains(where: { $0.id == character.id }) {
                combinedCharacters.append(character)
            }
        }
        
        if let data = try? JSONEncoder().encode(combinedCharacters) {
            userDefaults.set(data, forKey: charactersKey)
        }
    }
    
    func getCharacters() -> [CharacterModel] {
        guard let data = userDefaults.data(forKey: charactersKey),
              let characters = try? JSONDecoder().decode([CharacterModel].self, from: data)
        else {
            return []
        }
        return characters
    }
    
}
