//
//  UIScrollViewExtension.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 02.06.2021.
//

import UIKit

extension UIScrollView {
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame = self.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollRectToVisible(frame, animated: animated)
    }
    
}
