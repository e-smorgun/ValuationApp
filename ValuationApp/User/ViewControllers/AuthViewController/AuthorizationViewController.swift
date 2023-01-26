//
//  AuthorizationViewController.swift
//  CoffeeApp
//
//  Created by Evgeny on 4.10.22.
//

import RxRelay
import RxSwift
import RxCocoa
import Firebase

class AuthorizationViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?
    var didAuthClosure: (() -> Void)?
    var disposeBag = DisposeBag()
    var coordinator: AuthCoordinator?

    @IBOutlet var goToRegButton: UIButton!
    @IBOutlet var AuthButton: UIButton!
    @IBOutlet var rootView: AuthorizationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthButton.rx.tap.subscribe(onNext: { [weak self]  in
            let login = self?.rootView.loginTextField.text!
            let password = self?.rootView.passwordTextField.text!
            
            if(!login!.isEmpty && !password!.isEmpty) {
                Auth.auth().signIn(withEmail: login!, password: password!) { result, error in
                    if error == nil {
                            self?.didAuthClosure?()
                    } else {
                        self?.showAlert()
                    }
                }
            } else {
                self?.showAlert()
            }
        }).disposed(by: disposeBag)

        goToRegButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
    }
    
    deinit {
        print("AuthorizationViewController deinit")
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Invalid data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AuthorizationViewController {
    enum Event {
        case login
    }
}
