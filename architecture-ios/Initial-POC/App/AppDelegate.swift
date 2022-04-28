//
//  AppDelegate.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import Foundation
import UIKit
import Core
import os

var isUserLoggedIn: Bool = false
var isAppLaunched: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let log = Logger(subsystem: "app.appdelegate", category: "Application")
        log.warning("⚠️ Warn : this application is starting")
        
        AppNavigation.shared.register([.welcome], with: WelcomeHandler())
        AppNavigation.shared.register([.login, .forgotPassword], with: LoginHandler())
        AppNavigation.shared.register([.home], with: HomeHandler())
        AppNavigation.shared.register([.profile], with: ProfileHandler())
                
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
            AppNavigation.shared.show([.welcome], animated: true)
            isAppLaunched = true
        } else if isAppLaunched && !isUserLoggedIn {
            if !AppNavigation.shared.resolve(deeplink) { AppNavigation.shared.show([.welcome, .login], animated: true) }
        } else {
            AppNavigation.shared.resolve(deeplink)
        }
    }
}

extension Journey {
    static let welcome: Journey = Journey(rawValue: "welcome")
    static let login: Journey = Journey(rawValue: "login")
    static let forgotPassword: Journey = Journey(rawValue: "forgotPassword")
    static let home: Journey = Journey(rawValue: "home")
    static let profile: Journey = Journey(rawValue: "profile")
}
