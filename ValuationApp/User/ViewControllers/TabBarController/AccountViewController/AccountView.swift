//
//  AccountView.swift
//  ValuationApp
//
//  Created by Evgeny on 9.12.22.
//

import Foundation
import UIKit

class AccountView: UIView {
   
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.layer.cornerRadius = 23
         }
    }
    
    @IBOutlet weak var supportButton: UIButton! {
        didSet {
            supportButton.layer.cornerRadius = 23
         }
    }
}
