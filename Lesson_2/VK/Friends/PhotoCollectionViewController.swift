//
//  PhotoCollectionViewController.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
//    let photo = ["2a", "3a", "4a", "5a", "6a", "7a", "8a", "9a", "10a", "11a"]

    let photoGallery = PhotoGallery()
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        }
    }
//func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "pickPhotoSegue" {
//            let photoVC = segue.destination as! SliderViewController
//            let cell = sender as! PhotoCollectionViewCell
//            if let image = photoVC.image?.first {
//                cell.photoImageView.image = image
//            }
            
//            photoVC.image = cell.photoImageView.image
//        }
//    }
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let aveillableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = aveillableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoGallery.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCVCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photoImageView.image = photoGallery.photos[indexPath.item]
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SliderViewController") as! SliderViewController
        vc.photoGallery = photoGallery
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true )
    }
}
