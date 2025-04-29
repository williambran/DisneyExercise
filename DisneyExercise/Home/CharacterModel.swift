//
//  CharacterModel.swift
//  DisneyExercise
//
//  Created by William Brando Estrada Tepec on 4/27/25.
//

struct APIResponse:  Decodable {
    var info: Info?
    var data: [CharacterModel]
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
        case fav
    }
    init(
        id: Int,
        name: String? = nil,
        imageUrl: String? = nil,
        sourceUrl: String? = nil,
        fav: Bool = false
    ) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.sourceUrl = sourceUrl
        self.fav = fav
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id        = try container.decode(Int.self,     forKey: .id)
        name      = try container.decodeIfPresent(String.self, forKey: .name)
        imageUrl  = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        fav       = try container.decodeIfPresent(Bool.self,   forKey: .fav) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,       forKey: .id)
        try container.encodeIfPresent(name,      forKey: .name)
        try container.encodeIfPresent(imageUrl,  forKey: .imageUrl)
        try container.encodeIfPresent(sourceUrl, forKey: .sourceUrl)
        try container.encode(fav,      forKey: .fav)
    }
}
