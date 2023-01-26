//
//  AddNewObjectViewModel.swift
//  ValuationApp
//
//  Created by Evgeny on 14.12.22.
//

import Foundation
import UIKit
import RxRelay
import RxSwift
import Firebase

class AddNewObjectViewModel {

    var ref: DatabaseReference!
    
    func addNewObjectToDataBase(object: Property) {
        object.property_type = "Order"
        print("userID: ", object.userID,
              "bathroom: ", object.bathroom,
              "region: " , object.region,
              "finishing_work: ", object.finishing_work,
              "material: ", object.material,
              "view_from_window: ", object.view_from_window,
              "square: ", object.square,
              "cost_per_square_meter: ", object.cost_per_square_meter,
              "address: ", object.address,
              "balcony: ", object.balcony,
              "full_cost: ", object.full_cost,
              "floor: ", object.floor,
              "metro: ", object.metro,
              "property_type: ", object.property_type)
        
        var analogsArr: [Property] = []

        ref = Database.database().reference()
        ref.child("property").observeSingleEvent(of: .value, with: { [self] (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {
                    if value["property_type"]! as? String == "Analog" {
                            let analog: Property = Property(address: value["address"] as! String,
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
            }
            
            var objectsArrToCompare: [Property] = []


            for property in analogsArr {
                if (property.region == object.region) {
                    if (objectsArrToCompare.count == 3) {
                        break
                    } else {
                        objectsArrToCompare.append(property)
                    }
                }
            }
            
            self.compareObject(analogArray: objectsArrToCompare, object: object)
            
        }) { error in
        print(error.localizedDescription)
        }
    }

    func compareObject(analogArray: [Property], object: Property) {
        var costPerSqMeterArr: [Double] = []
        
        for array in analogArray {
            if object.view_from_window == "Солнечная сторона" {
                if (array.view_from_window != "Солнечная сторона") {
                    array.cost_per_square_meter *= 0.93
                }
            }
            //------------------------------------------------------------------------------------------------------
            if object.material == "Кирпич" {
                if array.material == "Панели" {
                    array.cost_per_square_meter *= 1.02
                } else if array.material == "Блок" {
                    array.cost_per_square_meter *= 0.98
                }
            } else if object.material == "Панели" {
                if array.material == "Кирпич" {
                    array.cost_per_square_meter *= 0.98
                } else if array.material == "Блок" {
                    array.cost_per_square_meter *= 0.96
                }
            } else if object.material == "Блок" {
                if array.material == "Кирпич" {
                    array.cost_per_square_meter *= 1.02
                } else if array.material == "Панели" {
                    array.cost_per_square_meter *= 1.04
                }
            }
            //------------------------------------------------------------------------------------------------------
            if object.bathroom == "Раздельный" {
                if (array.bathroom != "Раздельный") {
                    array.cost_per_square_meter *= 0.93
                }
            }
            //------------------------------------------------------------------------------------------------------
            if object.floor == 1 {
                if array.floor > 1 && array.floor < 4 {
                    array.cost_per_square_meter *= 1.03
                } else if array.floor > 3 && array.floor < 6 {
                    array.cost_per_square_meter *= 1.05
                } else if array.floor > 5 {
                    array.cost_per_square_meter *= 1.04
                }
            } else if object.floor > 1 && object.floor < 4 {
                if array.floor == 1 {
                    array.cost_per_square_meter *= 0.98
                } else if array.floor > 3 && array.floor < 6 {
                    array.cost_per_square_meter *= 1.03
                } else if array.floor > 5 {
                    array.cost_per_square_meter *= 1.02
                }
            } else if object.floor > 3 && object.floor < 6 {
                if array.floor == 1 {
                    array.cost_per_square_meter *= 0.95
                } else if array.floor > 1 && array.floor < 4 {
                    array.cost_per_square_meter *= 1.02
                } else if array.floor > 5 {
                    array.cost_per_square_meter *= 1.01
                }
            } else if object.floor > 5 {
                if array.floor == 1 {
                    array.cost_per_square_meter *= 0.96
                } else if array.floor > 1 && array.floor < 4 {
                    array.cost_per_square_meter *= 0.98
                } else if array.floor > 3 && array.floor < 6 {
                    array.cost_per_square_meter *= 1.01
                }
            }
            
            costPerSqMeterArr.append(array.cost_per_square_meter)
        }
        //------------------------------------------------------------------------------------------------------
        var sum: Double = costPerSqMeterArr.reduce(0, +)
        sum /= Double(costPerSqMeterArr.count)
        sum *= 100.0
        var buffer = Int(sum)
        object.cost_per_square_meter = Double(buffer) / 100.0
        //------------------------------------------------------------------------------------------------------
        object.full_cost = object.cost_per_square_meter * Double(object.square)
        
        
        let ref = Database.database().reference().child("property")
        
        ref.childByAutoId().updateChildValues(["userID": object.userID ,
                                               "address": object.address ,
                                               "floor": object.floor,
                                               "square": object.square,
                                               "metro": object.metro,
                                               "cost_per_square_meter": object.cost_per_square_meter,
                                               "full_cost": object.full_cost,
                                               "balcony": object.balcony,
                                               "bathroom": object.bathroom,
                                               "finishing_work": object.finishing_work,
                                               "property_type": object.property_type,
                                               "region": object.region,
                                               "view_from_window": object.view_from_window,
                                               "material": object.material])
    }
}
