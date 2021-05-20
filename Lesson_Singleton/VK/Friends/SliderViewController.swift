//
//  SliderViewController.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class SliderViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var photoGallery: PhotoGallery!
    let countCells = 1
    var indexPath: IndexPath!
    let identifire = "FullScreeneCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "FullScreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifire)
    }
}
extension SliderViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoGallery.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! FullScreenCollectionViewCell
        cell.photoView.image = photoGallery!.photos[indexPath.item]
        
        return cell
    }
}


 
