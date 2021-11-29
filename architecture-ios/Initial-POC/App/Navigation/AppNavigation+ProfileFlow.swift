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
        let profileDependencies = ProfileDependencies(deeplink, baseFlowDelegate, baseFlowDataSource, DependencyProvider.networking, DependencyProvider.analytics, customProfileAnalytics as? ProfileAnalyticsProtocol
        )
        
        return ProfileLauncher.start(with: profileDependencies)
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
