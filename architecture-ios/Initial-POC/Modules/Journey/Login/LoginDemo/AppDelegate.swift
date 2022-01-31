//
//  AppDelegate.swift
//  LoginDemo
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import UIKit
import Core

var isUserLoggedIn: Bool = false
var isAppLaunched: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppNavigation.shared.register([.login, .forgotPassword], with: LoginHandler())
        AppNavigation.shared.register([.home], with: HomeHandler())
        
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
            AppNavigation.shared.show([.login], animated: true)
            isAppLaunched = true
        } else if isAppLaunched && !isUserLoggedIn {
            if !AppNavigation.shared.resolve(deeplink) { AppNavigation.shared.show([.login], animated: true) }
        } else {
            AppNavigation.shared.resolve(deeplink)
        }
    }
}

extension Journey {
    static let login: Journey = Journey(rawValue: "login")
    static let forgotPassword: Journey = Journey(rawValue: "forgotPassword")
    static let home: Journey = Journey(rawValue: "home")
}

