//
//  AddNewObjectView.swift
//  ValuationApp
//
//  Created by Evgeny on 14.12.22.
//

import Foundation
import UIKit

class AddNewObjectView: UIView {
    @IBOutlet var nextPageButton: UIButton! {
        didSet{
            nextPageButton.layer.cornerRadius = 23
        }
    }
    
    @IBOutlet weak var metroTF: UITextField!
    @IBOutlet weak var squareTF: UITextField!
    @IBOutlet weak var floorTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
}
