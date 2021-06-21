//
//  GroupsCell.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 31.05.2021.
//

import UIKit
import Kingfisher

final class GroupCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.makeCircle()
    }
    
    func configure(group: Group) {
        textLabel?.text = group.title
        
        if let imageUrl = group.imageUrl, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            imageView?.kf.setImage(with: resource) { [weak self] _ in
                self?.setNeedsLayout()
            }
        }
    }

}
