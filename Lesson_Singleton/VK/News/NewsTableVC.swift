//
//  NewsTableVC.swift
//  VK
//
//  Created by Сергей Зайцев on 21.01.2021.
//


import UIKit

class NewsTableVC: UITableViewController {

    var friendsNews = [User(nameSurnameFriend: "Ирина Иванова", imageFriend: ["1"]),
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
    User(nameSurnameFriend: "Анна Шапиро", imageFriend: ["23"]),
    User(nameSurnameFriend: "Ирина Иванова", imageFriend: ["11"]),
    User(nameSurnameFriend: "Света Сергеева", imageFriend: ["12"]),
    User(nameSurnameFriend: "Диана Дмитриевна", imageFriend: ["13"]),
    User(nameSurnameFriend: "Лера Морозова", imageFriend: ["14"]),
    User(nameSurnameFriend: "Полина LoL", imageFriend: ["15"]),
    User(nameSurnameFriend: "Ирина  Blues", imageFriend: ["16"]),
    User(nameSurnameFriend: "Рената Камалова", imageFriend: ["17"]),
    User(nameSurnameFriend: "Оля Шапиро", imageFriend: ["18"]),
    User(nameSurnameFriend: "Эльза", imageFriend: ["19"]),
    User(nameSurnameFriend: "Галина bi", imageFriend: ["20"]),
    User(nameSurnameFriend: "Яна Попмушка", imageFriend: ["22"]),
    User(nameSurnameFriend: "Анна Шапиро", imageFriend: ["24"])]
   
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsNews.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        let friendNews = friendsNews[indexPath.row]
        
        cell.configure(for: friendNews)
        
        return cell
    }
}
