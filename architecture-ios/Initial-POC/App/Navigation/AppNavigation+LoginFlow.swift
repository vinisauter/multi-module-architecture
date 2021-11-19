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
    func startLogin(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil, loginAnalytics: JourneyModuleAnalyticsProtocol? = nil, subJourney: JourneyModule? = nil) -> UIViewController {
        let defaultStart = LoginLauncher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics, loginAnalytics: loginAnalytics as? LoginAnalyticsProtocol)
        
        if let subJourney = subJourney {
            switch subJourney {
            case .forgotPassword:
                return LoginLauncher.startForgotPassword(from: deeplink, baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics, loginAnalytics: loginAnalytics as? LoginAnalyticsProtocol)
            default: break
            }
        }
        
        return defaultStart
    }
    
    func handleLoginFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        isUserLoggedIn = journey == .home
        setRootViewController(start(journey), from: viewController, animated: true)
        resolveDeeplinkIfNeeded()
    }
    
    func handleGetLoginFlow(from journey: JourneyModule, to subJourney: JourneyModule? = nil, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        switch journey {
        case .profile: return start(.login, to: subJourney, from: journey, baseFlowDelegate: baseFlowDelegate, moduleAnalytics: LoginAnalyticsProfileAdapter(profileAnalytics: analytics))
        default: return start(.login, from: journey, baseFlowDelegate: baseFlowDelegate)
        }
    }
}
