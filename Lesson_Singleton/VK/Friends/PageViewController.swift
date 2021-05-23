//
//  PageViewController.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class PageViewController: UIPageViewController {
    let photo = ["2a", "3a", "4a", "5a", "6a", "7a", "8a", "9a", "10a", "11a"]
    var imagesUser = [User]()
    var imagesName = [String]()
    var titleItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setupSliderView()
        
        if let imagesFriendController = showViewControllerAtIndex(0) {
            setViewControllers([imagesFriendController],
                               direction: .forward,
                               animated: true)
            
        }
        
        setupNavigationBar()
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ImagesFriendController? {
                
        guard index >= 0, index < imagesName.count,
            let imagesFriendController = storyboard?.instantiateViewController(withIdentifier: "ImagesFriendController") as? ImagesFriendController
            else { return nil }
        
        imagesFriendController.images = UIImage(named: imagesName[index])
        imagesFriendController.currentPage = index
        imagesFriendController.numberOfPages = imagesName.count
        
        return imagesFriendController
    }
    
    private func setupSliderView() {
        
        for (_,imageName) in imagesUser.enumerated() {
            imagesName.append(contentsOf: imageName.imageFriend)
        }
    }
    
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        guard titleItem != nil else { return }
        title = titleItem
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
// Переход назад
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ImagesFriendController).currentPage
        pageNumber -= 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
// Переход вперед
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ImagesFriendController).currentPage
        pageNumber += 1
        
        return showViewControllerAtIndex(pageNumber)
    }
}
