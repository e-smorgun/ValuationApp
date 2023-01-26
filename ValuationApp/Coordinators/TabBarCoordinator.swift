//
//  TabBarCoordinator.swift
//  CoffeeApp
//
//  Created by Evgeny on 6.10.22.
//

import Foundation
import UIKit

enum TabBarPage {
    case myOrder
    case account

    init?(index: Int) {
        switch index {
        case 0:
            self = .myOrder
        case 1:
            self = .account
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .myOrder:
            return "myOrder"
        case .account:
            return "Account"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .myOrder:
            return 0
        case .account:
            return 1
        }
    }
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [.myOrder, .account]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1)
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.myOrder.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())

        switch page {
        case .myOrder:
            let myOrderVC = MyOrderViewController.createObject()
            myOrderVC.didSendEventClosure = { [weak self] in
                self?.showFirstAddNewOrder()
            }
            navController.pushViewController(myOrderVC, animated: true)
        case .account:
            let accountVC = AccountViewController.createObject()
            accountVC.didSendEventClosure = { [weak self] in
                self?.showSupportViewController()
            }
            navController.pushViewController(accountVC, animated: true)
        }
        
        return navController
    }
}

extension TabCoordinator {
    func showSupportViewController() {
        let SupportVC = SupportViewController.createObject()
        SupportVC.didSendEventClosure = { [weak self] in
            self?.start()
        }
        navigationController.pushViewController(SupportVC, animated: true)
    }
    
    func showFirstAddNewOrder() {
        let newOrder = FirstNewAnalogViewController.createObject()
        newOrder.didSendEventClosure = { [weak self] newOrderToDB in
            self?.showSecondAddNewOrder(order: newOrderToDB)
        }
        navigationController.pushViewController(newOrder, animated: true)
    }
    
    func showSecondAddNewOrder(order: Property) {
        let newObject = AddNewObjectViewController.createObject()
        newObject.newObject = order
        newObject.didSendEventClosure = { [weak self] in
            self?.start()
        }
        navigationController.pushViewController(newObject, animated: true)
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}

