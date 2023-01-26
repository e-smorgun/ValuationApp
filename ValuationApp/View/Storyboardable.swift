//
//  Storyboardable.swift
//  ValuationApp
//
//  Created by Evgeny on 8.12.22.
//

import Foundation

import Foundation

import UIKit

protocol Storyboardable {
    static func createObject() -> Self
}

extension Storyboardable where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
