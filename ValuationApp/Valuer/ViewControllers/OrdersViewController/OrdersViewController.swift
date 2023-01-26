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

class OrdersViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?

    var ref: DatabaseReference!
    var disposeBag = DisposeBag()
    var viewModel = OrdersViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Заказы"
        tableView.register(UINib(nibName: "AnalogsCell", bundle: nil), forCellReuseIdentifier: "AnalogsCell")
        
        viewModel.analogsArray.bind(to: tableView.rx.items(cellIdentifier: "AnalogsCell", cellType: AnalogsCell.self)) { index, item, cell in
            cell.configureForAnalog(analog: item)
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.loadData()
    }
}
