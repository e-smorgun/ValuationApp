//
//  RegView.swift
//  ValuationApp
//
//  Created by Evgeny on 8.12.22.
//

import Foundation
import UIKit

class RegistrationView: UIView {
    
    @IBOutlet weak var goToSignInButton: UIButton!
    
    @IBOutlet var registerButton: UIButton! {
        didSet {
            registerButton.layer.cornerRadius = 23
         }
    }
    
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.layer.borderColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1).cgColor
            nameTextField.layer.cornerRadius = 100
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
