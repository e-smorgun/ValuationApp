//
//  WorkWithUserView.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import Foundation
import RxRelay
import RxSwift
import Firebase

class WorkWithUsersViewModel {
    var userArray = BehaviorRelay<[User]>(value: [])
    var ref: DatabaseReference!

    func loadData() {
        var userArr: [User] = []

        ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                        var user: User = User(userID: value["id"] as! String,
                                              userName: value["name"] as! String,
                                              userEmail: value["mail"] as! String,
                                              userRole: value["role"] as! String,
                                              userPhone: value["userPhone"] as! String)
                    userArr.append(user)
                }
                self.userArray.accept(userArr)
            }
        }) { error in
        print(error.localizedDescription)
        }
    }
    
    func changeRole(index: Int) {
        
        ref = Database.database().reference()
        if userArray.value[index].userRole == "1" {
            userArray.value[index].userRole = "2"

        } else if userArray.value[index].userRole == "2" {
            userArray.value[index].userRole = "1"
        }
        ref.child("users").child(userArray.value[index].userID).setValue(["id" : userArray.value[index].userID,
                                                                          "mail": userArray.value[index].userEmail,
                                                                          "name": userArray.value[index].userName,
                                                                          "role": userArray.value[index].userRole,
                                                                          "userPhone": userArray.value[index].userPhone])
    }
}
