//
//  Group.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import UIKit
import RealmSwift
import FirebaseDatabase

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
final class FirebaseGroup {
    let title: String
    var ref: DatabaseReference?
    
    init(title: String, postcode: Int) {
        self.title = title
    }
    
    init?(snapshot: DataSnapshot?) {
        guard
            let value = snapshot?.value as? [String: Any],
            let title = value["title"] as? String
            else { return nil }
        
        self.title = title
        self.ref = snapshot?.ref
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "title": title
        ]
    }
}

