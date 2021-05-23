//
//  FreindTableViewCell.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit


class FreindTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animationButton: UILabel!
    @IBAction func animationImageBottom(_ sender: UIButton) {
        animationImage()
        let animation = CASpringAnimation(keyPath: "transform.scale")

                animation.fromValue = 0.8
                animation.toValue = 1
                animation.stiffness = 200
                animation.mass = 5
                animation.duration = 5
                animation.fillMode = CAMediaTimingFillMode.backwards

                self.photoImage.layer.add(animation, forKey: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = photoImage.frame.size.width / 2
        photoImage.contentMode = .scaleAspectFill
        animationImage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setFreind (objectCell: User) {
        self.photoImage.image = UIImage(named: objectCell.imageFriend.first!)
        self.nameLabel.text = objectCell.nameSurnameFriend
    }
    private func animationImage () {

        let animation = CASpringAnimation(keyPath: "transform.scale")

        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 5
        animation.duration = 5
        animation.fillMode = .backwards

        self.photoImage.layer.add(animation, forKey: nil)
    }
    func configure(for model: User) {

        nameLabel.text = model.nameSurnameFriend
        photoImage.image = UIImage(named: model.imageFriend.first!)
    }
}
