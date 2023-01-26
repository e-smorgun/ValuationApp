//
//  StatisticsViewModel.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import Foundation

import Foundation
import RxRelay
import Firebase
import RxSwift

class StatisticsViewModel {
    var ref: DatabaseReference!

    var allUsers: Int = 0
    var valuerUsers: Int = 0
    var users: Int = 0
    var analogs: Int = 0
    var objects: Int = 0
    var support: Int = 0
    
    func loadUsers() {
        ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { [self] (snapshot) in

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
        }) { error in
        print(error.localizedDescription)
        }
    }
    
    func loadObjects() {
        ref = Database.database().reference()
        ref.child("property").observeSingleEvent(of: .value, with: { (snapshot) in

            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["property_type"] as! String == "Object" {
                        self.objects += 1
                    } else if value["property_type"] as! String == "Analog" {
                        self.analogs += 1
                    }
                }
            }
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
        }) { error in
        print(error.localizedDescription)
        }
    }
}
