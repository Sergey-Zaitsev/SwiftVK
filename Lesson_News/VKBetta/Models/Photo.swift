//
//  Photo.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 01.06.2021.
//

import Foundation
import RealmSwift

final class Photo: Object, Decodable {
    @objc dynamic var imageUrl = ""
    @objc dynamic var friendId = 0
    
    override class func primaryKey() -> String? {
        return "imageUrl"
    }
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case photo = "photo_604"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }
}
