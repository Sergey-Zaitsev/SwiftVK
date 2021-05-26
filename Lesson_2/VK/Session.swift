//
//  Session.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class Session: CustomStringConvertible {
    static let shared = Session()
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    
    var description: String {
        return "Рады Вас снова видеть: \(token)"
    }
    
}
