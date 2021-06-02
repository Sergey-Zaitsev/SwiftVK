//
//  GroupsViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 31.05.2021.
//

import UIKit

final class MyGroupsViewController: UITableViewController {
    
    lazy var service = VKService()
    
    var groups: [Group] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.request(.groups) { [weak self] (groups: [Group]) in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
    
//     MARK: - Navigation
    
  @IBAction func addGroup(_ sender: UIStoryboardSegue) {
        guard
            let controller = sender.source as? AllGroupsViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow
            else { return }
        
        let selectedGroup = controller.groups[indexPath.row]
        
        if !groups.contains(selectedGroup) {
            groups.append(selectedGroup)
            tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
