//
//  AddNewObjectViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 14.12.22.
//

import UIKit
import RxSwift
import RxRelay

class AddNewObjectViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?

    @IBOutlet var rootView: AddNewObjectView!
    var newObject: Property!
    var viewModel = AddNewObjectViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.nextPageButton.rx.tap.subscribe(onNext: { [weak self]  in
            
            self?.newObject.address = self?.rootView.addressTF.text ?? ""
            self?.newObject.floor = Int(self?.rootView.floorTF.text ?? "") ?? 0
            self?.newObject.square = Int(self?.rootView.squareTF.text ?? "") ?? 0
            self?.newObject.metro = Int(self?.rootView.metroTF.text ?? "") ?? 0
            self?.viewModel.addNewObjectToDataBase(object: (self?.newObject)!)
            self?.didSendEventClosure?()
        })
    }
    
    @IBAction func switchPressed(_ sender: UISwitch ) {
        switch sender.isOn {
        case true:
            newObject.balcony = "Есть"
        case false:
            newObject.balcony = "Отсутствует"
        }
    }
}
