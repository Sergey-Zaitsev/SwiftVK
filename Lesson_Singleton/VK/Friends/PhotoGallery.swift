//
//  PhotoGallery.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class PhotoGallery{
    var photos = [UIImage]()
    init() {
        setupGallery()
    }
    func setupGallery() {
        for i in 1...24 {
            let photo = UIImage(named: "\(i)")!
            photos.append(photo)
        }
    }
}
