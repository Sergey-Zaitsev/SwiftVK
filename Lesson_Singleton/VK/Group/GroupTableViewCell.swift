//
//  GroupTableViewCell.swift
//  VK
//
//  Created by Сергей Зайцев on 08.01.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    
    @IBOutlet weak var emojLabel: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emojLabel.layer.cornerRadius = emojLabel.frame.size.height / 2
        emojLabel.contentMode = .scaleAspectFill
        animationImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func set (object: Group) {
        self.emojLabel.image = UIImage(named: object.groupImage)
        self.nameGroup.text = object.name
        self.descriptionLabel.text = object.description
    }
    private func animationImage () {

        let animation = CASpringAnimation(keyPath: "transform.scale")

        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 5
        animation.duration = 5
        animation.fillMode = .backwards

        self.emojLabel.layer.add(animation, forKey: nil)
    }
    func configure(for model: User) {

        emojLabel.image = UIImage(named: model.imageFriend.first!)
    }
}
