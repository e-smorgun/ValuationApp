//
//  FirstNewAnalogViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 11.12.22.
//

import UIKit
import Firebase
import RxSwift

class FirstNewAnalogViewController: UIViewController, Storyboardable {
    
    var disposeBag = DisposeBag()
    var didSendEventClosure: ((Property) -> Void)?
    
    @IBOutlet var rootView: FirstNewAnalogView!
    

    var newAnalog: Property = Property(address: "", floor: 0, square: 0, metro: 0, cost_per_square_meter: 0, full_cost: 0, balcony: "Есть", bathroom: "Раздельный", material: "Кирпич", finishing_work: "Отсутствует", property_type: "", region: "Советский", view_from_window: "Солнечная сторона", userID: Auth.auth().currentUser?.uid ?? "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("newanalog", newAnalog.bathroom, newAnalog.finishing_work, newAnalog.region, newAnalog.userID)
        
        rootView.nextPageButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?(self!.newAnalog)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func windowIndexChanged(_ sender: Any) {
        
        switch rootView.windowSC.selectedSegmentIndex
        {
        case 0:
            newAnalog.view_from_window = "Солнечная сторона"
        case 1:
            newAnalog.view_from_window = "Не солнечная сторона"
        default:
            break
        }
    }
    
    @IBAction func regionIndexChanger(_ sender: Any) {
        
        switch rootView.regionSC.selectedSegmentIndex
        {
        case 0:
            newAnalog.region = "Советский"
        case 1:
            newAnalog.region = "Фрунзенский"
        case 2:
            newAnalog.region = "Центральный"
        default:
            break
        }

    }
    
    @IBAction func materialIndexChanged(_ sender: Any) {
        
        switch rootView.materialSC.selectedSegmentIndex
        {
        case 0:
            newAnalog.material = "Кирпич"
        case 1:
            newAnalog.material = "Панели"
        case 2:
            newAnalog.material = "Блок"
        default:
            break
        }
    }
    
    @IBAction func finishWorkIndexChanged(_ sender: Any) {
        
        switch rootView.finishingWorkSC.selectedSegmentIndex
        {
        case 0:
            newAnalog.finishing_work = "Отсутствует"
        case 1:
            newAnalog.finishing_work = "Простые"
        case 2:
            newAnalog.finishing_work = "Усовершенствованные"
        default:
            break
        }
    }
    
    @IBAction func bathroomIndexChanged(_ sender: Any) {
        
        switch rootView.bathroomSC.selectedSegmentIndex
        {
        case 0:
            newAnalog.bathroom = "Раздельный"
        case 1:
            newAnalog.bathroom = "Совмещенный"
        default:
            break
        }
    }
    
}
