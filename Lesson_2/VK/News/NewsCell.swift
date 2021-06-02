//
//  NewsCell.swift
//  VK
//
//  Created by Сергей Зайцев on 21.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var imageGroup: UIImageView!
    {
        didSet {
            imageGroup.layer.cornerRadius = imageGroup.frame.size.height / 2
            imageGroup.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var imageFromGroup: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(for model: User) {

        nameGroup.text = model.nameSurnameFriend
        imageGroup.image = UIImage(named: model.imageFriend.last!)
        imageFromGroup.image = UIImage(named: model.imageFriend.last!)
//        textFromGroup.text = "\(model.nameSurnameFriend) обновил(а) фото"
    }
    @IBOutlet weak var like: LikeControl!
    @IBAction func click(_ sender: Any) {
        guard let likeControl = sender as? LikeControl else {
            return
        }
        if likeControl.isLike {
            likeControl.isLike = false
            likeControl.countLike -= 1
        } else {
            likeControl.isLike = true
            likeControl.countLike += 1
        }
    }
}
