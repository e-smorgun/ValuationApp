//
//  AppCoordinator.swift
//  ValuationApp
//
//  Created by Evgeny on 8.12.22.
//

import Foundation
import UIKit
import Firebase

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
            
    var ref: DatabaseReference!
//    var role: String = ""

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        showLoginFlow()
    }
        
    func showLoginFlow() {
        let authCoordinator = AuthCoordinator.init(navigationController)
        authCoordinator.start()
        childCoordinators.append(authCoordinator)    }
    
    func showMainFlow() {
        ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["id"]! as? String == Auth.auth().currentUser?.uid {
                        if value["role"] as! String == "1" {
                            let tabCoordinator = TabCoordinator.init(self.navigationController)
                            tabCoordinator.start()
                            self.childCoordinators.append(tabCoordinator)
                        }; if value["role"] as! String == "2"{
                            let tabValuerCoordinator = TabValuerCoordinator.init(self.navigationController)
                            tabValuerCoordinator.start()
                            self.childCoordinators.append(tabValuerCoordinator)
                        }
                    }
                }
            }
        }) { error in
        print(error.localizedDescription)
        }
    }
    
    func loadUserRole(userID: String) {
        var user: User = User(userID: "", userName: "", userEmail: "", userRole: "", userPhone: "")
        
        ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["id"]! as? String == userID {
                        let user1: User = User(userID: value["id"] as! String ,
                                               userName: value["name"] as! String,
                                               userEmail: value["mail"] as! String,
                                               userRole: value["role"] as! String,
                                               userPhone: value["userPhone"] as! String)
                        user = user1
                    }
                }
            }
        }) { error in
        print(error.localizedDescription)
        }
    }
}

