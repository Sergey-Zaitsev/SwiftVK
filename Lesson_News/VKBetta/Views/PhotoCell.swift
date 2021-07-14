//
//  PhotoCell.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 31.05.2021.
//

import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func configure(photo: Photo) {
        if let url = URL(string: photo.imageUrl) {
            let resource = ImageResource(downloadURL: url)
            imageView?.kf.setImage(with: resource) { [weak self] _ in
                self?.setNeedsLayout()
            }
        }
    }
    
}
