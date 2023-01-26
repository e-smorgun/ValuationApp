//
//  SupportView.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import Foundation
import UIKit

class SupportView: UIView {

    @IBOutlet var sendButton: UIButton! {
        didSet {
            sendButton.layer.cornerRadius = 23
        }
    }

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var MessageTextField: UITextField!
}
