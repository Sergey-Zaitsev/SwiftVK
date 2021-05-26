//
//  session.swift
//  VK
//
//  Created by Сергей Зайцев on 25.05.2021.
//

final class UserSession {
    static let instance = UserSession()
    
    var token = ""
    var userID = 0
    
    private init() { }
}
