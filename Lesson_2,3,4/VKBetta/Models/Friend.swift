//
//  Friend.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import Foundation
import RealmSwift

struct Friend: Decodable {
    var name: String
    var imageUrl: String?
    var photos: [String] = []
    var id: Int
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        let firstName = try container.decode(String.self, forKey: .firstName)
        let lastName = try container.decode(String.self, forKey: .lastName)
        self.name = firstName + " " + lastName
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }
}
