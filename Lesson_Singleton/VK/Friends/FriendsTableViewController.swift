//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Сергей Зайцев on 07.01.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredUsers = [User] ()
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
//    var objects = [User (nameSurnameFriend: "Ирина Иванова", imageFriend: ["1", "11"]),
//                   User(nameSurnameFriend: "Света Сергеева", imageFriend: ["2", "12"]),
//                   User(nameSurnameFriend: "Диана Дмитриевна", imageFriend: ["3", "13"]),
//                   User(nameSurnameFriend: "Лера Морозова", imageFriend: ["4", "14"]),
//                   User(nameSurnameFriend: "Полина LoL", imageFriend: ["5", "15"]),
//                   User(nameSurnameFriend: "Ирина  Blues", imageFriend: ["6", "16"]),
//                   User(nameSurnameFriend: "Рената Камалова", imageFriend: ["7", "17"]),
//                   User(nameSurnameFriend: "Оля Шапиро", imageFriend: ["8", "18"]),
//                   User(nameSurnameFriend: "Эльза", imageFriend: ["9", "19"]),
//                   User(nameSurnameFriend: "Галина bi", imageFriend: ["10", "20"]),
//                   User(nameSurnameFriend: "Яна Попмушка", imageFriend: ["21", "22"]),
//                   User(nameSurnameFriend: "Анна Шапиро", imageFriend: ["23", "24"])]
    var friendsSection = [String]()
    var friendsDictionary = [String: [User]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Список друзей"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupSearchController()
        tableView.sectionIndexColor = .black
        sortFriend()
        
    }
    
    // MARK: - Help Function
    
    private func sortFriend() {
        
        for friend in objects {
            
            let key = "\(friend.nameSurnameFriend[friend.nameSurnameFriend.startIndex])"
            
            if var friendValue = friendsDictionary[key] {
                friendValue.append(friend)
                friendsDictionary[key] = friendValue
            } else {
                friendsDictionary[key] = [friend]
            }
            
            friendsSection = [String](friendsDictionary.keys).sorted()
        }
    }
    
    // MARK: - Table view data source
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyFreindsTableViewCell
        
                if isFiltering {
        
                    cell.configure(for: filteredUsers [indexPath.row])
                } else {
        
                    let friendKey = friendsSection[indexPath.section]
        
                    if var friendValue = friendsDictionary[friendKey.uppercased()] {
        
                        if isFiltering {
                            friendValue = filteredUsers
                        }
        
                        cell.selectionStyle = .none
                        cell.configure(for: friendValue [indexPath.row])
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                objects.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath] , with: .fade)
            }
        }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        let header = view as! UITableViewHeaderFooterView
//
//        header.alpha = 0.3
//        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
//        header.textLabel?.textAlignment = .left
//        header.textLabel?.textColor = .white
//    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addImage" {
            
            let detailFriendController = segue.destination as? DetailFriendController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                if isFiltering {
                    
                    let friends = filteredUsers[indexPath.row]
                    
                    detailFriendController?.titleItem = friends.nameSurnameFriend
                    detailFriendController?.friendsImage.removeAll()
                    detailFriendController?.friendsImage.append(friends)
                } else {
                    
                    let friendKey = friendsSection[indexPath.section]
                    
                    if let friendValue = friendsDictionary[friendKey.uppercased()] {
                        
                        let image = friendValue[indexPath.row]
                        let name = friendValue[indexPath.row]
                        
                        detailFriendController?.titleItem = name.nameSurnameFriend
                        detailFriendController?.friendsImage.removeAll()
                        detailFriendController?.friendsImage.append(image)
                    }
                }
            }
        }
    }
}
