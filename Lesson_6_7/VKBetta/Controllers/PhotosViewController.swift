//
//  PhotosViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 31.05.2021.
//

import UIKit
import RealmSwift

final class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var service = VKService()
    lazy var realm = try! Realm()
    
    var friendId: Int = 0
    var photos: [Photo] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromRealm()
        loadFromNetwork()
        
    }
    func loadFromRealm() {
        let objects = realm.objects(Photo.self).filter("friendId == %@", friendId)
        photos = Array(objects)
        collectionView?.reloadData()
    }
    func loadFromNetwork() {
        service.request(.photos(id: friendId), Photo.self) { [weak self] _ in
            self?.loadFromRealm()
        
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? SliderViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first
        {
            controller.title = title
            controller.photos = photos
            controller.currentIndex = indexPath.row
        }
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        cell.configure(photo: photos[indexPath.row])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    enum Layout {
        static let columns: CGFloat = 3
        static let spacing: CGFloat = 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - Layout.spacing * (Layout.columns - 1)) / Layout.columns
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spacing
    }
    
}
