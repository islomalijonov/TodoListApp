//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainPage = TodosListViewController()
        mainPage.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        let navigationController = UINavigationController(rootViewController: mainPage)
        setupNavigationBarAppearance(for: navigationController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func setupNavigationBarAppearance(for navigationController: UINavigationController) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .blue
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
        navigationController.navigationBar.barTintColor = .blue
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = .white
    }
}

