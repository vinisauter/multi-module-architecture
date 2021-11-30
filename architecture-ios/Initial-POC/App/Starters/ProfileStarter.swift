//
//  ProfileStarter.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Profile

class ProfileStarter: ModuleStarter {
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: JourneyModule?, _ value: Any?) -> UIViewController {
        let profileDependencies = ProfileDependencies(url, baseFlowDelegate, baseFlowDataSource, StructuralDependencyProvider.networking, StructuralDependencyProvider.analytics, customModuleAnalytics as? ProfileAnalyticsProtocol, value)
        
        return ProfileLauncher.start(with: profileDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getPath() -> String {
        return "profile"
    }
    
    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .home:
            AppNavigation.shared.show([.home], from: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
    }
}
