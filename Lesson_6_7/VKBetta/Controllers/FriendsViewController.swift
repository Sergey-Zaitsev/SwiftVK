//
//  FriendsViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import UIKit
import RealmSwift

final class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    lazy var service = VKService()
    lazy var realm = try! Realm()
    var notificationToken: NotificationToken?
    var items: Results<Friend>!
    var sections: [String] = []
//    var friends: [Friend] = []
    var filteredFriends: [Friend] = [] {
        didSet {
            sections = Array(Set(filteredFriends.map { $0.name.prefix(1).uppercased() }
            )).sorted()
           
            }
        }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToRealm()
//        loadFromRealm()
        loadFromNetwork()
        
    }
//    func loadFromRealm() {
//        let objects = realm.objects(Friend.self)
//        friends = Array(objects)
//        filteredFriends = friends
//        tableView?.reloadData()
//    }
    private func loadFromNetwork() {
        service.request(.friends, Friend.self)
    }
    private func bindToRealm () {
        items = realm.objects(Friend.self)
        notificationToken = items.observe { [weak self] (changes)  in
            switch changes {
            case .initial (let items):
                self?.filteredFriends = Array(items)
                self?.tableView.reloadData()
                
            case .update(let items, _, _, _):
                self?.filteredFriends = Array(items)
                self?.tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? PhotosViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            let friend = items (for: indexPath.section)[indexPath.row]
            controller.title = friend.name
            controller.friendId = friend.id
        }
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items(for: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendCell
        cell.configure(friend: items(for: indexPath.section) [indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    private func items (for section: Int) -> [Friend] {
        return filteredFriends.filter {
            $0.name.uppercased().starts(with: sections[section])
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredFriends = Array(items)
        } else {
            filteredFriends = items.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
