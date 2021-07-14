//
//  ServiceLocator.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    let vkService = VKServiceNews()
    let imageService = ImageService()
    let newsService: NewsfeedService
    let userService: UserService
    
    private init() {
        newsService = NewsfeedService(vkService: vkService)
        userService = UserService(vkService: vkService)
    }
}
