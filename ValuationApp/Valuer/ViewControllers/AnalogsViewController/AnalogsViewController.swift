//
//  AnalogsViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 10.12.22.
//

import UIKit
import RxRelay
import RxSwift
import Firebase

class AnalogsViewController: UIViewController, Storyboardable {

    var didSendEventClosure: (() -> Void)?

    @IBOutlet var rootView: AnalogsView!
    var ref: DatabaseReference!
    var disposeBag = DisposeBag()
    var viewModel = AnalogsViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Аналоги"
        tableView.register(UINib(nibName: "AnalogsCell", bundle: nil), forCellReuseIdentifier: "AnalogsCell")
        
        viewModel.analogsArray.bind(to: tableView.rx.items(cellIdentifier: "AnalogsCell", cellType: AnalogsCell.self)) { index, item, cell in
            cell.configureForAnalog(analog: item)
        }.disposed(by: disposeBag)
        
        rootView.addNewAnalog.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didSendEventClosure?()
        }).disposed(by: disposeBag)
        
        rootView.filtrButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.showAlert()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.loadData()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Фильтрация по стоимости", message: "Введите выше какой стоимости вы хотите увидеть аналоги", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Фильтрация", style: .default, handler: { action in
            let textField = alert.textFields![0]
            let cost = textField.text
            if cost == "" {
            self.viewModel.loadData(cost: "0")
            } else {self.viewModel.loadData(cost: cost!)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cброс", style: .default, handler: { action in
            self.viewModel.loadData(cost: "0")
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
