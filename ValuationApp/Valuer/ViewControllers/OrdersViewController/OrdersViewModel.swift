//
//  OrdersViewModel.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import Foundation
import RxRelay
import RxSwift
import Firebase

class OrdersViewModel {
    var analogsArray = BehaviorRelay<[Property]>(value: [])
    var ref: DatabaseReference!

    func loadData() {
        var analogsArr: [Property] = []

        ref = Database.database().reference()
        ref.child("property").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["property_type"]! as? String == "Order" {
                        var analog: Property = Property(address: value["address"] as! String,
                                                        floor: value["floor"] as! Int,
                                                        square: value["square"] as! Int,
                                                        metro: value["metro"] as! Int ,
                                                        cost_per_square_meter: value["cost_per_square_meter"] as! Double,
                                                        full_cost: value["full_cost"] as! Double,
                                                        balcony: value["balcony"] as! String ,
                                                        bathroom: value["bathroom"] as! String ,
                                                        material: value["material"] as! String,
                                                        finishing_work: value["finishing_work"] as! String,
                                                        property_type: value["property_type"] as! String,
                                                        region: value["region"] as! String,
                                                        view_from_window: value["view_from_window"] as! String,
                                                        userID: value["userID"] as! String)
                        analogsArr.append(analog)
                    }
                }
                self.analogsArray.accept(analogsArr)
            }
        }) { error in
        print(error.localizedDescription)
        }
    }
}
