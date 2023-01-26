//
//  RequestCell.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import Foundation
import UIKit
class RequestCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    func configure(request: Support) {
        messageLabel.text = request.message
        userIDLabel.text = request.user
    }
}
