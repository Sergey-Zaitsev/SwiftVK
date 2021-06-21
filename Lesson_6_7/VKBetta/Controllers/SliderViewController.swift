//
//  SliderViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 02.06.2021.
//

import UIKit
import Kingfisher

final class SliderViewController: UIViewController {
    
    var photos: [Photo] = []
    var currentIndex = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos.forEach { addSlide(photo: $0) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollToPage(page: currentIndex, animated: true)
    }
    
    // MARK: - Helpers
    
    private func addSlide(photo: Photo) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if let url = URL(string: photo.imageUrl) {
            let resource = ImageResource(downloadURL: url)
            imageView.kf.setImage(with: resource)
        }
        
        stackView.addArrangedSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
}

