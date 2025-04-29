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
    
    init( repository: HomeRepositoryProtocol, initData:[CharacterModel] = []) {
        self.repository = repository
        self.data = initData
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
    
    func saveCharacterFavorite(_ character: CharacterModel) {
        if let index = data.firstIndex(where: { $0.id == character.id }) {
            data[index].fav.toggle()
            repository.saveFavoriteCharacter(character)
        }
    }
    
    func getCharacterFavorites() {
        let response = repository.fetchCharacterFav()
        DispatchQueue.main.async {
            self.data = response
        }
    }
}
