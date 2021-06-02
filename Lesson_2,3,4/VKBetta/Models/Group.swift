//
//  Group.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import UIKit
import RealmSwift

struct Group: Decodable, Equatable {
    var title: String
    var imageUrl: String?
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_50"
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }
    
}

