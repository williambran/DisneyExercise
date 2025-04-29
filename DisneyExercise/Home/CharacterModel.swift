//
//  CharacterModel.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//

struct APIResponse:  Decodable {
    var info: Info?
    let data: [CharacterModel]
}

struct Info: Decodable {
    let totalPages: Int
    let count: Int
    let previousPage: String?
    let nextPage: String?
}

struct CharacterModel: Hashable, Decodable, Encodable{
    var id: Int
    var name: String?
    var imageUrl: String?
    var sourceUrl: String?
    
    var fav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case imageUrl = "imageUrl"
        case sourceUrl = "sourceUrl"
    }
}
