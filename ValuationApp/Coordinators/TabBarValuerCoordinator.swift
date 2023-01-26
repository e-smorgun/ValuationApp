//
//  TabBarValuerCoordinator.swift
//  ValuationApp
//
//  Created by Evgeny on 10.12.22.
//

import Foundation
import UIKit

enum ValuerTabBarPage {
    case orders
    case analogs
    case users
    case setting

    init?(index: Int) {
        switch index {
        case 0:
            self = .orders
        case 1:
            self = .analogs
        case 2:
            self = .users
        case 3:
            self = .setting
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .orders:
            return "Заказы"
        case .analogs:
            return "Аналоги"
        case .users:
            return "Работа с пользователями"
        case .setting:
            return "Настройки"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .orders:
            return 0
        case .analogs:
            return 1
        case .users:
            return 2
        case .setting:
            return 3
        }
    }
}

protocol TabBarValuerCoordinator: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabValuerCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [ValuerTabBarPage] = [.orders, .analogs, .users, .setting]
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
        tabBarController.selectedIndex = ValuerTabBarPage.orders.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: ValuerTabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())

        switch page {
        case .orders:
            let orderVC = OrdersViewController.createObject()
            navController.pushViewController(orderVC, animated: true)
//            let menuVC = MenuViewController.createObject()
//            menuVC.didGoToInfoController = { [weak self] coffee in
//                self?.showInfoController(coffee: coffee)
//            }
//         navController.pushViewController(menuVC, animated: true)
        case .analogs:
            let analogsVC = AnalogsViewController.createObject()
            analogsVC.didSendEventClosure = { [weak self] in
                self?.showFirstNewAnalog()
            }
            navController.pushViewController(analogsVC, animated: true)
//            let giftVC = GiftViewController.createObject()
//            navController.pushViewController(giftVC, animated: true)
        case .users:
            let usersVC = WorkWithUsersViewController.createObject()
            usersVC.didGoToSupportEventClosure = { [weak self] in
                self?.showSupportRequest()
            }
            
            usersVC.didGoToStatisticsEventClosure = { [weak self] in
                self?.showStatistics()
            }
            
            usersVC.didCloseAlertClosure = { [weak self] in
                self?.start()
            }
            navController.pushViewController(usersVC, animated: true)
        case .setting:
            let accountVC = AccountViewController.createObject()
            navController.pushViewController(accountVC, animated: true)
//            let accountVC = AccountViewController.createObject()
//            navController.pushViewController(accountVC, animated: true)
        }
        
        return navController
    }
}

extension TabValuerCoordinator {
    func showFirstNewAnalog() {
        let newAnalog = FirstNewAnalogViewController.createObject()
        newAnalog.didSendEventClosure = { [weak self] newAnalog in
            self?.showSecondNewAnalog(analog: newAnalog)
        }
        navigationController.pushViewController(newAnalog, animated: true)
    }
    
    func showSecondNewAnalog(analog: Property) {
        let newAnalog = SecondNewAnalogViewController.createObject()
        newAnalog.newAnalog = analog
        newAnalog.didSendEventClosure = { [weak self] in
            self?.start()
        }
        navigationController.pushViewController(newAnalog, animated: true)
    }
    
    func showSupportRequest() {
        let supportVC = SupportRequestViewController.createObject()
        supportVC.didSendEventClosure = { [weak self] in
            self?.start()
        }
        navigationController.pushViewController(supportVC, animated: true)
    }
    
    func showStatistics() {
        let statisticsVC = StatisticsViewController.createObject()
        statisticsVC.didSendEventClosure = { [weak self] in
            self?.start()
        }
        navigationController.pushViewController(statisticsVC, animated: true)
    }
}

// MARK: - UITabBarControllerDelegate
extension TabValuerCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}


