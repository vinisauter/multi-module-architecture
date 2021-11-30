//
//  LoginStarter.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Login

class LoginStarter: ModuleStarter {
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: JourneyModule?, _ value: Any?) -> UIViewController {
        let loginDependencies = LoginDependencies(url, baseFlowDelegate, StructuralDependencyProvider.networking, StructuralDependencyProvider.analytics, customModuleAnalytics as? LoginAnalyticsProtocol, value)
        
        var startViewController: UIViewController = LoginLauncher.start(with: loginDependencies)
        
        if let subJourney = subJourney {
            switch subJourney {
            case .forgotPassword:
                startViewController = LoginLauncher.startForgotPassword(with: loginDependencies)
            default: break
            }
        }
        
        return startViewController
    }
    
    func canStart() -> Bool {
        return isAppLaunched && !isUserLoggedIn
    }
    
    func getName() -> String {
        return "login"
    }
    
    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        isUserLoggedIn = journey == .home
        switch journey {
        case .home:
            AppNavigation.shared.show([.home], from: viewController, animated: true)
            AppNavigation.shared.resolveDeeplinkIfNeeded()
            break
            
        case .welcome:
            AppNavigation.shared.show([.welcome], from: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        switch journey {
        case .profile: return AppNavigation.shared.start(.login, to: subJourney, from: journey, baseFlowDelegate: baseFlowDelegate, customModuleAnalytics: analytics != nil ? LoginAnalyticsProfileAdapter(profileAnalytics: analytics) : nil)
        default: return AppNavigation.shared.start(.login, from: journey, baseFlowDelegate: baseFlowDelegate)
        }
    }
}
