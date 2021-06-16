//
//  Friend.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import Foundation
import RealmSwift

final class Friend: Object, Decodable {
    @objc dynamic var name = ""
    @objc dynamic var imageUrl: String?
    @objc dynamic var id = 0
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case id
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        let firstName = try container.decode(String.self, forKey: .firstName)
        let lastName = try container.decode(String.self, forKey: .lastName)
        self.name = firstName + " " + lastName
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }
}
