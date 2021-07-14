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
    
    var friends: [Friend] = []
    var filteredFriends: [Friend] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromRealm()
        loadFromNetwork()
        
    }
    func loadFromRealm() {
        let objects = realm.objects(Friend.self)
        friends = Array(objects)
        filteredFriends = friends
        tableView?.reloadData()
    }
    func loadFromNetwork() {
        service.request(.friends, Friend.self) { [weak self] _ in
            self?.loadFromRealm()
        
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? PhotosViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            let friend = friends[indexPath.row]
            controller.title = friend.name
            controller.friendId = friend.id
        }
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendCell
        cell.configure(friend: filteredFriends[indexPath.row])
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredFriends = friends
        } else {
            filteredFriends = friends.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}