//
//  AuthView.swift
//  ValuationApp
//
//  Created by Evgeny on 8.12.22.
//

import Foundation
import UIKit

class AuthorizationView: UIView {
    
    @IBOutlet var authButton: UIButton! {
        didSet {
            authButton.layer.cornerRadius = 23
         }
    }
    
    @IBOutlet var goToRegButton: UIButton! {
        didSet {
         }
    }
    
    @IBOutlet var loginTextField: UITextField! {
        didSet {
            loginTextField.layer.borderColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1).cgColor
            loginTextField.layer.cornerRadius = 100
        }
    }
    
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.cornerRadius = 23
            passwordTextField.layer.borderColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1).cgColor
        }
    }
}
