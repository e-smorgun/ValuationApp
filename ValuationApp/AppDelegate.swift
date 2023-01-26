//
//  AppDelegate.swift
//  ValuationApp
//
//  Created by Evgeny on 8.12.22.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let navigationController: UINavigationController = .init()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
        coordinator = AppCoordinator.init(navigationController)
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            print(Auth.auth().currentUser?.uid)

            if (user == nil) {
                self.coordinator?.start()
            } else {
                self.coordinator?.showMainFlow()
            }
        }
        
        return true
    }
}
