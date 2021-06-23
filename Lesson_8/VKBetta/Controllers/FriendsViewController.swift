//
//  FriendsViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import UIKit
import FirebaseAuth

final class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    lazy var service = VKService()
    lazy var auth = FirebaseAuth.Auth.auth()
    
    var friends: [Friend] = []
    var filteredFriends: [Friend] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.request(.friends) { [weak self] (friends: [Friend]) in
            self?.friends = friends
            self?.filteredFriends = friends
            self?.tableView.reloadData()
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
    
    @IBAction func ignoutTapped(_ sender: UIBarButtonItem) {
        do {
            try auth.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print(error)
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
