//
//  NewGroupTableViewController.swift
//  VK
//
//  Created by Сергей Зайцев on 08.01.2021.
//

import UIKit

class NewGroupTableViewController: UITableViewController {
    
     var group = Group(groupImage: "", name: "", description: "", isFavorite: false)
    
    @IBOutlet weak var imageFild: UITextField!
    @IBOutlet weak var nameGroup: UITextField!
    @IBOutlet weak var noteNewGroup: UITextField!
    @IBAction func textChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    private func updateUI () {
        imageFild.text = group.groupImage
        nameGroup.text = group.name
        noteNewGroup.text = group.description
    }
    @IBOutlet weak var saveButtom: UIBarButtonItem!
    private func updateSaveButtonState() {
        let groupImage = imageFild.text ?? ""
        let nameText = nameGroup.text ?? ""
        let noteText = noteNewGroup.text ?? ""
        saveButtom.isEnabled = !nameText.isEmpty && !noteText.isEmpty && !groupImage.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        updateUI()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        _ = imageFild.text ?? ""
        let name = nameGroup.text ?? ""
        let note = noteNewGroup.text ?? ""
        self.group = Group(groupImage: "", name: name, description: note, isFavorite: self.group.isFavorite)
        
    }
}
