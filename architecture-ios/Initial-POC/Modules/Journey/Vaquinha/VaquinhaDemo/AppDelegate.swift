//
//  AppDelegate.swift
//  Vaquinha
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core

var isUserLoggedIn: Bool = false
var isAppLaunched: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppNavigation.shared.register([.vaquinha], with: VaquinhaHandler())
        AppNavigation.shared.register([.profile], with: ProfileHandler())
        
        setupRootViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppNavigation.shared.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    private func setupRootViewController(with deeplink: String? = nil) {
        if !isAppLaunched {
            AppNavigation.shared.show([.vaquinha], animated: true)
            isAppLaunched = true
        } else if isAppLaunched && !isUserLoggedIn {
            if !AppNavigation.shared.resolve(deeplink) { AppNavigation.shared.show([.vaquinha], animated: true) }
        } else {
            AppNavigation.shared.resolve(deeplink)
        }
    }


}

