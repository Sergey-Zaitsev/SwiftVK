//
//  FreindTableVC.swift
//  VK
//
//  Created by Сергей Зайцев on 20.05.2021.
//

import UIKit

class FreindTableVC: UITableViewController {
    private let networkService = NetworkService()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredUsers = [User]()
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    let objects = [User (nameSurnameFriend: "Ирина Иванова", imageFriend: ["1"]),
                   User(nameSurnameFriend: "Света Сергеева", imageFriend: ["2"]),
                   User(nameSurnameFriend: "Диана Дмитриевна", imageFriend: ["3"]),
                   User(nameSurnameFriend: "Лера Морозова", imageFriend: ["4"]),
                   User(nameSurnameFriend: "Полина LoL", imageFriend: ["5"]),
                   User(nameSurnameFriend: "Ирина  Blues", imageFriend: ["6"]),
                   User(nameSurnameFriend: "Рената Камалова", imageFriend: ["7"]),
                   User(nameSurnameFriend: "Оля Шапиро", imageFriend: ["8"]),
                   User(nameSurnameFriend: "Эльза", imageFriend: ["9"]),
                   User(nameSurnameFriend: "Галина bi", imageFriend: ["10"]),
                   User(nameSurnameFriend: "Яна Попмушка", imageFriend: ["21"]),
                   User(nameSurnameFriend: "Анна Шапиро", imageFriend: ["23"])]
    
    var friendsSection = [String]()
    var friendsDictionary = [String: [User]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getUserFriends()
        self.title = "Мои друзья"
        setupSearchController()
        tableView.sectionIndexColor = .blue
        sortFriend()
    }
    private func sortFriend() {
        
        for objects in objects {
            
            let key = "\(objects.nameSurnameFriend[objects.nameSurnameFriend.startIndex])"
            
            if var friendValue = friendsDictionary[key] {
                friendValue.append(objects)
                friendsDictionary[key] = friendValue
            } else {
                friendsDictionary[key] = [objects]
            }
            
            friendsSection = [String](friendsDictionary.keys).sorted()
        }
    }
    @IBAction func unvindSegueFreind (segue: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickPhotoSegue" {
            let detailPhoto = segue.destination as! DetailVC
            let cell = sender as! FreindTableViewCell
            detailPhoto.image = cell.photoImage.image
            
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if isFiltering {
            return 1
        }
        
        return friendsSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredUsers.count
        }
        
        let friendKey = friendsSection[section]
        
        if let friend = friendsDictionary[friendKey] {
            return friend.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! FreindTableViewCell
        let objectFreind = objects[indexPath.row]
        cell.setFreind(objectCell: objectFreind)
        
        if isFiltering {
            
            cell.configure(for: filteredUsers[indexPath.row])
        } else {
            
            let friendKey = friendsSection[indexPath.section]
            
            if var friendValue = friendsDictionary[friendKey.uppercased()] {
                
                if isFiltering {
                    friendValue = filteredUsers
                }
                
                cell.selectionStyle = .none
                cell.configure(for: friendValue[indexPath.row])
            }
        }
        
        return cell
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSection
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isFiltering {
            return ""
        }
        
        return friendsSection[section]
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree: Double = 90 * .pi/180
        let rotation = CGFloat(degree)
        let rotationTransform = CATransform3DMakeRotation(rotation, 1, 0, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 1, delay: 0.5 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 400, 0)
        cell.layer.transform = translationTransform
        UIView.animate(withDuration: 1, delay: 1.2 * Double(indexPath.row), options: .curveEaseInOut) {
            cell.layer.transform = CATransform3DIdentity
        }


    }
}
