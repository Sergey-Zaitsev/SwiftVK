//
//  DetailVC.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class DetailVC: UIViewController {
    
    var image: UIImage?
    var photoDetail = User(nameSurnameFriend: "", imageFriend: [""])
    var titleItem: String?
    var friendsImage = [User]()
    
    @IBOutlet weak var photoFreind: UIImageView!
    
    private func updateUIDetail () {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        photoFreind.image = image

    }
    
    @IBAction func photoColection(_ sender: UIButton) {
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
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            guard segue.identifier == "seeImages" else { return }
            
            let pageViewController = segue.destination as? PageViewController
            
            pageViewController?.titleItem = titleItem
            pageViewController?.imagesUser = friendsImage
        }

    }
    @IBAction func PhotoGalery(_ sender: UIButton) {
    }
}
