//
//  Analogs.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import Foundation
import UIKit

class AnalogsCell: UITableViewCell {
    
    @IBOutlet weak var priceView: UIView!{
        didSet{
            priceView.layer.cornerRadius = 35
        }
    }
    
    @IBOutlet weak var userLabelStatic: UILabel!
    @IBOutlet weak var valuerStatic: UILabel!
    @IBOutlet weak var valuerLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var squareLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func configureForAnalog(analog: Property) {
        addressLabel.text = analog.address
        squareLabel.text = String(analog.square)
        priceLabel.text = "\(analog.cost_per_square_meter)$/\(analog.full_cost)$"
        if analog.valuerID == "" {
            valuerStatic.isHidden = true
            valuerLabel.isHidden = true
        } else {
            valuerLabel.text = analog.valuerID
        }
        userLabel.text = analog.userID
    }
    
    func configure(analog: Property) {
        addressLabel.text = analog.address
        squareLabel.text = String(analog.square)
        priceLabel.text = "\(analog.cost_per_square_meter)$/\(analog.full_cost)$"
        valuerStatic.isHidden = true
        valuerLabel.isHidden = true
        userLabel.isHidden = true
        userLabelStatic.isHidden = true
    }
}
