//
//  SearchGroupResults.swift
//  VK
//
//  Created by Сергей Зайцев on 09.01.2021.
//

//import UIKit
//
//extension GroupTableViewController: UISearchResultsUpdating {
//
//
//    func setupSearchController() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Поиск"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        
//        let searchBar = searchController.searchBar
//        filterContentForSearchText(searchBar.text!)
//    }
//    
//    func filterContentForSearchText(_ searchText: String) {
//
//
//        filteredUsers = friends.filter{ (user: User) -> Bool in
//            return user.nameSurnameFriend.contains(searchText)
//        }
//
//        tableView.reloadData()
//    }
//}
