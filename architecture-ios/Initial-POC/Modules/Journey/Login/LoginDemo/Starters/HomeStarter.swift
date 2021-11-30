//
//  HomeStarter.swift
//  LoginDemo
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import UIKit
import Core
import Home

class HomeStarter: ModuleStarter {
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: JourneyModuleAnalyticsProtocol?, _ subJourney: JourneyModule?) -> UIViewController {
        let homeDependencies = HomeDependencies(url, baseFlowDelegate, StructuralDependencyProvider.networking, StructuralDependencyProvider.analytics, customModuleAnalytics as? HomeAnalyticsProtocol)
        
        return HomeLauncher.start(with: homeDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getPath() -> String {
        return "home"
    }
    
    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .profile:
            AppNavigation.shared.push(journey, from: viewController)
            break
            
        case .login:
            AppNavigation.shared.set([.login], from: viewController, animated: false)
            isUserLoggedIn = false
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney)
    }
}

