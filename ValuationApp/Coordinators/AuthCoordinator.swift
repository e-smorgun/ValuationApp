import Foundation
import UIKit

protocol AuthCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

class AuthCoordinator: AuthCoordinatorProtocol {
    
    var tabCoordinator: AppCoordinator?
    var authCoordintator: AppCoordinator?
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
            
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showLoginViewController() {
        let loginVC = AuthorizationViewController.createObject()
        
        loginVC.didAuthClosure = { [weak self] in
//            let tabCoordinator = TabCoordinator.init((self?.navigationController)!)
//              tabCoordinator.start()
//            self?.childCoordinators.append(tabCoordinator)
        }
        
        loginVC.didSendEventClosure = { [weak self] in
            self?.showRegViewController()
        }

        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func showRegViewController() {
        let regVC = RegistrationViewController.createObject()
        regVC.didSendEventClosure = { [weak self] in
            self?.showLoginViewController()
        }
        navigationController.pushViewController(regVC, animated: true)
    }
}

