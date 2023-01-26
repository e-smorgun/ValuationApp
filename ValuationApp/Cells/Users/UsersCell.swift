//
//  UsersCell.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import Foundation
import UIKit

class UsersCell: UITableViewCell {
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    func configure(user: User) {
        userIDLabel.text = user.userID
        mailLabel.text = user.userEmail
        nameLabel.text = user.userName
        if user.userRole == "1" {
            roleLabel.text = "Пользователь"
        } else if user.userRole == "2"{
            roleLabel.text = "Оценщик"
        } else {
            roleLabel.text = "Неопределен"
        }
    }
}
