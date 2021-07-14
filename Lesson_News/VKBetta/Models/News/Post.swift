//
//  Post.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//

import Foundation

struct Post {
    var text: String?
    var likes: UInt = 0
    var views: UInt = 0
    var comments: UInt = 0
    var reposts: UInt = 0
    var date: Date!
    var user: Profile?
    var group: GroupNews?
    var photos: [PhotoNews] = []
}
