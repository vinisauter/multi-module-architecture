//
//  AppNavigation+HomeFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Home

extension AppNavigation {
    func startHome(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil, customHomeAnalytics: JourneyModuleAnalyticsProtocol? = nil, subJourney: JourneyModule? = nil) -> UIViewController {
        return HomeLauncher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics, customHomeAnalytics: customHomeAnalytics as? HomeAnalyticsProtocol)
    }
    
    func handleHomeFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .profile:
            push(start(.profile, baseFlowDelegate: self, baseFlowDataSource: self), from: viewController)
            break
            
        case .login:
            set([.welcome, .login], from: viewController, animated: false)
            isUserLoggedIn = false
            break
            
        default: break
        }
    }
    
    func handleGetHomeFlow(from journey: JourneyModule, to subJourney: JourneyModule? = nil, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        return start(.home, from: journey, baseFlowDelegate: baseFlowDelegate)
    }
}
