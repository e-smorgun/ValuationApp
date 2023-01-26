//
//  SupportRequestViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import UIKit
import RxRelay
import RxSwift
import Firebase

class SupportRequestViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?
    
    var disposeBag = DisposeBag()
    var viewModel = SupportRequestViewModel()
    @IBOutlet var rootView: SupportRequestView!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RequestCell", bundle: nil), forCellReuseIdentifier: "RequestCell")
        
        viewModel.requestArray.bind(to: tableView.rx.items(cellIdentifier: "RequestCell", cellType: RequestCell.self)) { index, item, cell in
            cell.configure(request: item)
        }.disposed(by: disposeBag)
        
        rootView.backButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.loadData()
    }
}
