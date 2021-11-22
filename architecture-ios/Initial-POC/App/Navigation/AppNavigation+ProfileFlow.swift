//
//  AppNavigation+ProfileFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Home
import Profile

extension AppNavigation {
    func startProfile(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil, baseFlowDataSource: BaseFlowDataSource? = nil, customProfileAnalytics: JourneyModuleAnalyticsProtocol? = nil, subJourney: JourneyModule? = nil) -> UIViewController {
        return ProfileLauncher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics, customProfileAnalytics: customProfileAnalytics as? ProfileAnalyticsProtocol)
    }
    
    func handleProfileFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .home:
            setRootViewController(start(.home, baseFlowDelegate: self), from: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleGetProfileFlow(from journey: JourneyModule, to subJourney: JourneyModule? = nil, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        return start(.profile, from: journey, baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: self)
    }
}
