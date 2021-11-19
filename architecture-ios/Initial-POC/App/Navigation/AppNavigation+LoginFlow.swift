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
    func startLogin(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil, loginAnalytics: JourneyModuleAnalyticsProtocol? = nil) -> UIViewController {
        return LoginLauncher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics, loginAnalytics: loginAnalytics as? LoginAnalyticsProtocol)
    }
    
    func handleLoginFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        isUserLoggedIn = journey == .home
        setRootViewController(start(journey), from: viewController, animated: true)
        resolveDeeplinkIfNeeded()
    }
    
    func handleGetLoginFlow(from journey: JourneyModule, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        switch journey {
        case .profile: return start(.login, from: journey, baseFlowDelegate: baseFlowDelegate, moduleAnalytics: LoginAnalyticsProfileAdapter(profileAnalytics: analytics))
        default: return start(.login, from: journey, baseFlowDelegate: baseFlowDelegate)
        }
    }
}
