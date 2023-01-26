//
//  AccountViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 9.12.22.
//

import Firebase
import RxRelay
import RxSwift
import RxCocoa

class AccountViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet var rootView: AccountView!
    
    var ref: DatabaseReference!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.logoutButton.rx.tap.subscribe(onNext: { [weak self]  in
            do {
                try Auth.auth().signOut()
                print("logout")
            } catch {
                print(error)
            }
        }).disposed(by: disposeBag)
        
        rootView.supportButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
      
        ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["id"]! as? String == Auth.auth().currentUser?.uid {
                        self.rootView.nameLabel.text = value["name"] as? String
                        self.rootView.emailLabel.text = value["mail"] as? String
                        if value["role"] as? String == "2" {
                            self.rootView.supportButton.isHidden = true
                        }
                    }
                }
            }
        }) { error in
        print(error.localizedDescription)
        }
        rootView.emailLabel.text = Auth.auth().currentUser?.email
        }
}
