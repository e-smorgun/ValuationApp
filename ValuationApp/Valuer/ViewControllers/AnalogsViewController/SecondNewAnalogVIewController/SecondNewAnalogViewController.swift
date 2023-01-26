//
//  SecondNewAnalogViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import UIKit
import Firebase
import RxSwift

class SecondNewAnalogViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?
    @IBOutlet var rootView: SecondNewAnalogView!
    var newAnalog: Property!
    var disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.nextPageButton.rx.tap.subscribe(onNext: { [weak self]  in
            
            self?.newAnalog.address = self?.rootView.addressTF.text ?? ""
            self?.newAnalog.floor = Int(self?.rootView.floorTF.text ?? "0")!
            self?.newAnalog.square = Int(self?.rootView.squareTF.text ?? "0")!
            self?.newAnalog.metro = Int(self?.rootView.metroTF.text ?? "0")!
            self?.newAnalog.full_cost = Double(self?.rootView.priceTF.text ?? "0")!
            //print(self?.newAnalog.cost_per_square_meter, self?.newAnalog.full_cost, self?.newAnalog.square)

            self?.newAnalog.cost_per_square_meter = (Double(exactly: self?.newAnalog.full_cost ?? 0)!) / (Double(exactly: self?.newAnalog.square ?? 0)!)
            var cost_per_meter: Int = Int((self?.newAnalog.cost_per_square_meter)! * 100)
            self?.newAnalog.cost_per_square_meter = Double(cost_per_meter) / 100.0

            self?.newAnalog.full_cost = (self?.newAnalog.cost_per_square_meter)! * Double((self?.newAnalog.square)!) * 100.0
            
            var price: Int = Int((self?.newAnalog.full_cost)!)
            self?.newAnalog.full_cost = Double(price) / 100.0

            self?.newAnalog.property_type = "Analog"
            
            //print("1", self?.newAnalog.userID, "2", self?.newAnalog.bathroom, "3", self?.newAnalog.region, "4", self?.newAnalog.finishing_work, "5", self?.newAnalog.material, "6", self?.newAnalog.view_from_window, "7", self?.newAnalog.square, "8", self?.newAnalog.cost_per_square_meter, "9",self?.newAnalog.address, "10", self?.newAnalog.balcony, "11", self?.newAnalog.full_cost, "12", self?.newAnalog.floor, "13", self?.newAnalog.metro, "14", self?.newAnalog.property_type)
            
            let ref = Database.database().reference().child("property")
            
            ref.childByAutoId().updateChildValues(["userID":self?.newAnalog.userID ?? "",
                                                   "address":self?.newAnalog.address ?? "",
                                                   "floor":self?.newAnalog.floor ?? "",
                                                   "square":self?.newAnalog.square ?? "",
                                                   "metro":self?.newAnalog.metro ?? "",
                                                   "cost_per_square_meter":self?.newAnalog.cost_per_square_meter ?? "",
                                                   "full_cost":self?.newAnalog.full_cost ?? "",
                                                   "balcony":self?.newAnalog.balcony ?? "",
                                                   "bathroom":self?.newAnalog.bathroom ?? "",
                                                   "finishing_work":self?.newAnalog.finishing_work ?? "",
                                                   "property_type":self?.newAnalog.property_type ?? "",
                                                   "region":self?.newAnalog.region ?? "",
                                                   "view_from_window":self?.newAnalog.view_from_window ?? "",
                                                   "material":self?.newAnalog.material ?? ""])
            
            self?.didSendEventClosure!()
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func switchPressed(_ sender: UISwitch ) {
        switch sender.isOn {
        case true:
            newAnalog.balcony = "Есть"
        case false:
            newAnalog.balcony = "Отсутствует"
        }
    }
}
