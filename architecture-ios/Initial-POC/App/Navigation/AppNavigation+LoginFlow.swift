//
//  AppNavigation+LoginFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Login
import Profile

extension AppNavigation {
    func startLogin(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil, customLoginAnalytics: JourneyModuleAnalyticsProtocol? = nil, subJourney: JourneyModule? = nil) -> UIViewController {
        let loginDependencies = LoginDependencies(deeplink, baseFlowDelegate, DependencyProvider.networking, DependencyProvider.analytics, customLoginAnalytics as? LoginAnalyticsProtocol)
        
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
    
    func handleLoginFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        isUserLoggedIn = journey == .home
        setRootViewController(start(journey), from: viewController, animated: true)
        resolveDeeplinkIfNeeded()
    }
    
    func handleGetLoginFlow(from journey: JourneyModule, to subJourney: JourneyModule? = nil, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        switch journey {
        case .profile: return start(.login, to: subJourney, from: journey, baseFlowDelegate: baseFlowDelegate, moduleAnalytics: analytics != nil ? LoginAnalyticsProfileAdapter(profileAnalytics: analytics) : nil)
        default: return start(.login, from: journey, baseFlowDelegate: baseFlowDelegate)
        }
    }
}
