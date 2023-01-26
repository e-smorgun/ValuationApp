//
//  Property.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import Foundation

class Property {
    var address: String = ""
    var floor: Int = 0
    var square: Int = 0
    var metro: Int = 0
    var cost_per_square_meter: Double = 0
    var full_cost: Double = 0
    var balcony: String = ""
    var bathroom: String = ""
    var material: String = ""
    var finishing_work: String = ""
    var property_type: String = ""
    var region: String = ""
    var view_from_window = ""
    var userID = ""
    var valuerID = ""
    
    init(address: String, floor: Int, square: Int, metro: Int, cost_per_square_meter: Double, full_cost: Double, balcony: String, bathroom: String, material: String, finishing_work: String, property_type: String, region: String, view_from_window: String = "", userID: String = "") {
        self.address = address
        self.floor = floor
        self.square = square
        self.metro = metro
        self.cost_per_square_meter = cost_per_square_meter
        self.full_cost = full_cost
        self.balcony = balcony
        self.bathroom = bathroom
        self.material = material
        self.finishing_work = finishing_work
        self.property_type = property_type
        self.region = region
        self.view_from_window = view_from_window
        self.userID = userID
    }
}
