//
//  PhotoVC.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class PhotoVC: UIViewController {
    
    var image: UIImage?

    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = image
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                print("Успешно ")
            }
        }
        
        present(shareController, animated: true, completion: nil)
    }
    
}
