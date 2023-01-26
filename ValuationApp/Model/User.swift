//
//  User.swift
//  ValuationApp
//
//  Created by Evgeny on 10.12.22.
//

import Foundation

class User {
    var userID: String = ""
    var userName: String = ""
    var userEmail: String = ""
    var userRole: String = ""
    var userPhone: String = ""

    
    init(userID: String, userName: String, userEmail: String, userRole: String, userPhone: String) {
        self.userID = userID
        self.userName = userName
        self.userEmail = userEmail
        self.userRole = userRole
        self.userPhone = userPhone
    }
}
