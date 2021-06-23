//
//  AllGroupsViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 02.06.2021.
//

import UIKit


final class AllGroupsViewController: UITableViewController, UISearchBarDelegate {
    
    lazy var service = VKService()
    
    var groups: [Group] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchGroups()
    }
    
    func searchGroups(_ text: String = "iOS") {
        service.request(.searchGroups(text: text)) { [weak self] (groups: [Group]) in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupCell
        cell.configure(group: groups[indexPath.row])
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroups(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

