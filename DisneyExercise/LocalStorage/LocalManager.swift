//
//  LocalManager.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/28/25.
//

import Foundation

protocol LocalManagerProtocol{
    func saveCharacters(_ characters: [CharacterModel])
    func saveFavoriteCharacter(_ character: CharacterModel)
    func getCharactersFavorites() -> [CharacterModel]
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
    
    func saveFavoriteCharacter(_ character: CharacterModel) {
        var chapters = getCharacters()
        if let index = chapters.firstIndex(where: { $0.id == character.id }) {
            var chapter = chapters[index]
            chapter.fav.toggle()
            chapters[index] = chapter
        }
        if let data = try? JSONEncoder().encode(chapters) {
            userDefaults.set(data, forKey: charactersKey)
        }
    }
    
    func getCharactersFavorites() -> [CharacterModel] {
        guard let data = userDefaults.data(forKey: charactersKey),
              let characters = try? JSONDecoder().decode([CharacterModel].self, from: data)
        else {
            return []
        }
        let charactersFavo = characters.filter ({ $0.fav == true })
        print("Lista de favoritos: ", charactersFavo)
        return charactersFavo
    }
    
}
