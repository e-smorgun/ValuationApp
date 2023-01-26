//
//  WorkWithUsersViewController.swift
//  ValuationApp
//
//  Created by Evgeny on 10.12.22.
//

import UIKit
import RxRelay
import RxSwift
import Firebase

class WorkWithUsersViewController: UIViewController, Storyboardable {

    var didGoToSupportEventClosure: (() -> Void)?
    var didGoToStatisticsEventClosure: (() -> Void)?
    var didCloseAlertClosure: (() -> Void)?

    var ref: DatabaseReference!
    var disposeBag = DisposeBag()
    var viewModel = WorkWithUsersViewModel()    
    @IBOutlet var rootView: WorkWithUsersView!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        showAlert()
        self.title = "Работа с пользователем"
        tableView.register(UINib(nibName: "UsersCell", bundle: nil), forCellReuseIdentifier: "UsersCell")
        
        viewModel.userArray.bind(to: tableView.rx.items(cellIdentifier: "UsersCell", cellType: UsersCell.self)) { index, item, cell in
            cell.configure(user: item)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.changeRole(index: indexPath.row)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        rootView.goToSupportRequestButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didGoToSupportEventClosure?()
        }).disposed(by: disposeBag)

        rootView.goToStatisticsButton.rx.tap.subscribe(onNext: { [weak self]  in
            self?.didGoToStatisticsEventClosure?()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.loadData()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Пароль администратора", message: "Введите пароль администратора", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Ввод", style: .default, handler: { action in
            let textField = alert.textFields![0]
            let password = textField.text
            if password != "1234" {
                self.didCloseAlertClosure?()
            }
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: { action in
            self.didCloseAlertClosure?()
            }))
        present(alert, animated: true, completion: nil)
    }
    
}
