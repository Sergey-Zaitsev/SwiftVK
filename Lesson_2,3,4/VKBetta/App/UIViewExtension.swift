//
//  UIViewExtension.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 02.06.2021.
//

import UIKit

extension UIView {
    
    func makeCircle() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
}
