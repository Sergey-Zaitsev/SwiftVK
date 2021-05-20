//
//  GroupTableViewController.swift
//  VK
//
//  Created by Сергей Зайцев on 08.01.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {
//    let searchController = UISearchController(searchResultsController: nil)
    var groupUsers = [Group]()
//    var searchBarIsEmpty: Bool {
        
//        guard let text = searchController.searchBar.text else { return false }
//
//        return text.isEmpty
//    }
    
//    var isFiltering: Bool {
//
//        return searchController.isActive && !searchBarIsEmpty
//    }
    var objects = [
    Group(groupImage: "1Group", name: "Русские не сдаются", description: "Про страну и людей.", isFavorite: false),
        Group(groupImage: "2Group", name: "Поклонники Apple", description: "Для тех кому не все равно.", isFavorite: false),
        Group(groupImage: "3Group", name: "Русские в деревне", description: "Про страну и людей.", isFavorite: false),
        Group(groupImage: "4Group", name: "Русские в городе", description: "Про страну и людей.", isFavorite: false),
        Group(groupImage: "5Group", name: "Русские на море", description: "Про страну и людей.", isFavorite: false),
        Group(groupImage: "6Group", name: "Только Русские", description: "Про страну и людей.", isFavorite: false)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мои группы"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
//        setupSearchController()
    }
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourseVC = segue.source as! NewGroupTableViewController
        let group = sourseVC.group
        if let selectIndexPath = tableView.indexPathForSelectedRow {
            objects[selectIndexPath.row] = group
            tableView.reloadRows(at: [selectIndexPath], with: .automatic)
        } else {
            let newIndexPath =  IndexPath(row: objects.count, section: 0 )
            objects.append(group)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editGroup" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let group = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newGroupVC = navigationVC.topViewController as! NewGroupTableViewController
        newGroupVC.group = group
        newGroupVC.title = "Редактирование группы"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        return cell
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
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveGroup = objects.remove(at: sourceIndexPath.row)
        objects.insert(moveGroup, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let vavorite = favoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, vavorite ])
    }
    func doneAction (at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName:  "checkmark.circle")
        return action
    }
    func favoriteAction (at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            object.isFavorite = !object.isFavorite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavorite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
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
        UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
}
