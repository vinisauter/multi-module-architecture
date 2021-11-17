//
//  AppDelegate.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRootViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppNavigation.shared.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard url.scheme == "app"  else { return true }
        
        setupRootViewController(with: url.absoluteString)
        
        return true
    }
    
    private func setupRootViewController(with deeplink: String? = nil) {
        if !isAppLaunched {
            AppNavigation.shared.setRootViewController(AppNavigation.shared.start(.welcome))
            isAppLaunched = true
        }
        
        AppNavigation.shared.resolve(deeplink)
    }
}

