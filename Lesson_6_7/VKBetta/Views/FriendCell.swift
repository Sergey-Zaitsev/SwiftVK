//
//  FriendCell.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 31.05.2021.
//

import UIKit
import Kingfisher

final class FriendCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.makeCircle()
    }
    
    func configure(friend: Friend) {
        textLabel?.text = friend.name
        
        if let imageUrl = friend.imageUrl,
           let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            imageView?.kf.setImage(with: resource) { [weak self] _ in
                self?.setNeedsLayout()
            }
        }
    }
}

