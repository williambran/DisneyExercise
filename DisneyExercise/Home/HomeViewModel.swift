//
//  HomeViewModel.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/26/25.
//

import Foundation
import SwiftUI


class HomeViewModel: ObservableObject {
    
    @Published var data: [CharacterModel] = []
    private var repository: HomeRepositoryProtocol
    
    init( repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadCharacters() async {
        do {
            let response = try await repository.fetchCharacters()
            DispatchQueue.main.async {
                self.data = response
            }
            
        } catch {
            print("Some Error")
        }
    }
    
    func saveCharacter(_ character: CharacterModel) {
        repository.saveFavoriteCharacter(character)
    }
    
    func getCharacterFavorites() {
         let response = repository.fetchCharacterFav()
        DispatchQueue.main.async {
            self.data = response
        }
    }
}
