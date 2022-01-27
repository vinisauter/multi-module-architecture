//
//  AppDelegate.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

var isUserLoggedIn: Bool = false
var isAppLaunched: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let appNavigation: AppNavigation = AppNavigation()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appNavigation.register([.welcome], with: WelcomeHandler(appNavigation: appNavigation))
        appNavigation.register([.login, .forgotPassword], with: LoginHandler(appNavigation: appNavigation))
        appNavigation.register([.home], with: HomeHandler(appNavigation: appNavigation))
        appNavigation.register([.profile], with: ProfileHandler(appNavigation: appNavigation))
                
        setupRootViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appNavigation.navigationController
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
            appNavigation.show([.welcome], animated: true)
            isAppLaunched = true
        } else if isAppLaunched && !isUserLoggedIn {
            if !appNavigation.resolve(deeplink) { appNavigation.show([.welcome, .login], animated: true) }
        } else {
            appNavigation.resolve(deeplink)
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
