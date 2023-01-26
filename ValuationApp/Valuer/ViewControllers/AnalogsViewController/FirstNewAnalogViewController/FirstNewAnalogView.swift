//
//  FirstNewAnalogView.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import Foundation
import UIKit

class FirstNewAnalogView: UIView {
    @IBOutlet var nextPageButton: UIButton! {
        didSet{
            nextPageButton.layer.cornerRadius = 23
        }
    }
    @IBOutlet weak var bathroomSC: UISegmentedControl!
    @IBOutlet weak var finishingWorkSC: UISegmentedControl!
    @IBOutlet weak var materialSC: UISegmentedControl!
    @IBOutlet weak var windowSC: UISegmentedControl!
    
    @IBOutlet weak var regionSC: UISegmentedControl!
}
