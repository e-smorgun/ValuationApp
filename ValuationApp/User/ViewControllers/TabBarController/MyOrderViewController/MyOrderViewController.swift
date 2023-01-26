//
//  OrdersViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 10.12.22.
//

import UIKit
import RxRelay
import RxSwift
import Firebase

class MyOrderViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?

    var ref: DatabaseReference!
    var disposeBag = DisposeBag()
    var viewModel = MyOrderViewModel()
    
    @IBOutlet weak var rootview: MyOrderView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Заказы"
        tableView.register(UINib(nibName: "AnalogsCell", bundle: nil), forCellReuseIdentifier: "AnalogsCell")
        
        viewModel.analogsArray.bind(to: tableView.rx.items(cellIdentifier: "AnalogsCell", cellType: AnalogsCell.self)) { index, item, cell in
            cell.configure(analog: item)
        }.disposed(by: disposeBag)
        
        rootview.addNewOrderButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
        
        rootview.filterButton.rx.tap.subscribe(onNext: { [weak self]  in
            let url: NSURL = URL(string: "TEL:375298312670")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }).disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.loadData()
    }
    

}
