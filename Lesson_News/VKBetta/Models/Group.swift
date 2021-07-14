//
//  Group.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import UIKit
import RealmSwift

final class Group: Object, Decodable {
    @objc dynamic var title = ""
    @objc dynamic var imageUrl: String?
    
    override class func primaryKey() -> String? {
        return "title"
    }
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_50"
    }
    
    // MARK: - Decodable
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }
    
}

