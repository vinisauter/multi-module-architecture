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
        AppNavigation.shared.setRootViewController(by: .Login)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppNavigation.shared.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

// MARK: Deeplink
extension AppDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme.localizedCaseInsensitiveCompare("testpoc") == .orderedSame, let view = url.host {
                
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
    
            parseDeepLink(view, parameters: parameters)
        }
        return true
    }
    
    func parseDeepLink(_ deepLink: String, parameters: [String: String]) {
        switch deepLink {
        case Journey.Home.rawValue:
            setupRootViewController(by: .Home, parameters: parameters)
        case Journey.Profile.rawValue:
            setupRootViewController(by: .Profile, parameters: parameters)
        default:
            setupRootViewController(by: .Login, parameters: parameters)
        }
    }
    
    func setupRootViewController(by deepLink: Journey, parameters: [String: String] = [:]) {
        AppNavigation.shared.setRootViewController(by: deepLink, deepLinkParameters: parameters)
        self.window?.rootViewController = AppNavigation.shared.navigationController
    }
}
