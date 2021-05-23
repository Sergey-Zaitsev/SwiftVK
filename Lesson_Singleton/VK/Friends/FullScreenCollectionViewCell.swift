//
//  FullScreenCollectionViewCell.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class FullScreenCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate{
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 0.3
        self.scrollView.maximumZoomScale = 2.0
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoView
    }
}
