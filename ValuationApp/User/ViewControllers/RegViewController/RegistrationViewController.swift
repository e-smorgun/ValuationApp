//
//  RegistrationViewController.swift
//  CoffeeApp
//
//  Created by Evgeny on 7.10.22.
//

import UIKit
import Firebase
import RxRelay
import RxSwift
import RxCocoa

class RegistrationViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?
    var disposeBag = DisposeBag()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet var goToSignInButton: UIButton!
    @IBOutlet var rootVeiw: RegistrationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        registerButton.rx.tap.subscribe(onNext: { [weak self]  in
            let name = self?.nameTextField.text!
            let login = self?.loginTextField.text!
            let password = self?.passwordTextField.text!
            
            print(name, login, password)
            
            if(!login!.isEmpty && !password!.isEmpty) {
                Auth.auth().createUser(withEmail: login!, password: password!) { result, error in
                    if error == nil {
                        if let result = result {
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["id" : Auth.auth().currentUser?.uid,
                                                                          "name" : name!,
                                                                          "mail" : login!,
                                                                          "role": "1",
                                                                          "userPhone": ""])
                            
                            self?.didSendEventClosure?()
                        }
                    }
                    else {
                        self?.showAlert(error: "The password must be 6 characters long or more.")
                    }
                }
            } else {
                self?.showAlert(error: "error")
            }
        }).disposed(by: disposeBag)
        
        goToSignInButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
        
    }
    
    deinit {
        print("RegistrationViewController deinit")
    }
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension RegistrationViewController {
    enum Event {
        case login
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        if(!login.isEmpty && !password.isEmpty) {
            Auth.auth().createUser(withEmail: login, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                    }
                }
            }
        } else {
            showAlert(error: "Fill in all an Fields")
        }
        return true
    }
}
