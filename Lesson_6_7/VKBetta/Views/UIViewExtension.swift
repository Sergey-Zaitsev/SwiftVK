//
//  UIViewExtension.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 31.05.2021.
//

import UIKit

extension UIView {
    
    func makeCircle() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
}
