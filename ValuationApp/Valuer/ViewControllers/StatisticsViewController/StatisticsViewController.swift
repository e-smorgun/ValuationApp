//
//  StatisticsViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import UIKit
import RxRelay
import RxSwift
import Firebase

class StatisticsViewController: UIViewController, Storyboardable {
    
    var didSendEventClosure: (() -> Void)?

    var disposeBag = DisposeBag()
    var viewModel = StatisticsViewModel()
    @IBOutlet var rootView: StatisticsView!
    var ref: DatabaseReference!

    var allUsers: Int = 0
    var valuerUsers: Int = 0
    var users: Int = 0
    var analogs: Int = 0
    var objects: Int = 0
    var support: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.backButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
        loadObjects()
        loadSupport()
    }
    
    func loadUsers() {
        ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in

            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    self.allUsers += 1
                    if value["role"] as! String == "1" {
                        self.users += 1
                    } else if value["role"] as! String == "2" {
                        self.valuerUsers += 1
                    }
                }
            }
            self.rootView.allUsersLabel.text = String(self.allUsers)
            self.rootView.userLabel.text = String(self.users)
            self.rootView.valuerLabel.text = String(self.valuerUsers)
        }) { error in
        print(error.localizedDescription)
        }
    }
    
    func loadObjects() {
        ref = Database.database().reference()
        ref.child("property").observeSingleEvent(of: .value, with: { (snapshot) in

            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["property_type"] as! String == "Order" {
                        self.objects += 1
                    } else if value["property_type"] as! String == "Analog" {
                        self.analogs += 1
                    }
                }
            }
            self.rootView.analogsLabel.text = String(self.analogs)
            self.rootView.objectLabel.text = String(self.objects)
        }) { error in
        print(error.localizedDescription)
        }
    }
    
    func loadSupport() {
        ref = Database.database().reference()
        ref.child("support_request").observeSingleEvent(of: .value, with: { (snapshot) in

            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    self.support += 1
                }
            }
            self.rootView.supportLabel.text = String(self.support)
        }) { error in
        print(error.localizedDescription)
        }
    }
}
