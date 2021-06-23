//
//  Session.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import Foundation

final class Session {
    
    var token = ""
    var userId = ""
    
    // MARK: - Singleton
    
    static let shared = Session()
    private init() {}
    
}
