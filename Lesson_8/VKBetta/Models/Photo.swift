//
//  Photo.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 01.06.2021.
//

import UIKit
import RealmSwift

struct Photo: Decodable {
    var imageUrl: String
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case photo = "photo_604"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(String.self, forKey: .photo)
    }
}
