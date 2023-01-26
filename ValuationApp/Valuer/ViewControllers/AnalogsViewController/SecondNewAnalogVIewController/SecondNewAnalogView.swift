//
//  SecondNewAnalogView.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import Foundation
import UIKit

class SecondNewAnalogView: UIView {
    
    @IBOutlet var nextPageButton: UIButton! {
        didSet{
            nextPageButton.layer.cornerRadius = 23
        }
    }
    
    
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var metroTF: UITextField!
    @IBOutlet weak var squareTF: UITextField!
    @IBOutlet weak var floorTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
}
