//
//  UIImage.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//

import UIKit

extension UIImage {
    
    var roundImage: UIImage? {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in:rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
