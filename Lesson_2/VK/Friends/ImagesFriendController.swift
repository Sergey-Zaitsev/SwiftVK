//
//  ImagesFriendController.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class ImagesFriendController: UIViewController {
    
    var images: UIImage?
    var currentPage = 0
    var numberOfPages = 0

    @IBOutlet weak var imagesFriend: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesFriend.image = images
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
        
        self.tabBarController?.tabBar.isHidden = true
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }
}

extension ImagesFriendController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imagesFriend
    }
}
