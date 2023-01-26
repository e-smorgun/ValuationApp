//
//  SupportViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import UIKit
import RxSwift
import RxRelay
import Firebase

class SupportViewController: UIViewController, Storyboardable {
    
    var didSendEventClosure: (() -> Void)?
    var disposeBag = DisposeBag()
    @IBOutlet var rootVeiw: SupportView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootVeiw.sendButton.rx.tap.subscribe(onNext: { [weak self]  in
            let ref = Database.database().reference().child("support_request")
            ref.childByAutoId().updateChildValues(["user" : Auth.auth().currentUser?.uid ?? "",
                                                   "message" : self?.rootVeiw.MessageTextField.text ?? ""])
            
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
        
        rootVeiw.backButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
        }
}
