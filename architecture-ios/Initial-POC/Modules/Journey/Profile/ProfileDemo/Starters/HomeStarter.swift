//
//  HomeStarter.swift
//  ProfileDemo
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import UIKit
import Core
import Home

class HomeStarter: ModuleHandler {
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: JourneyModule?, _ value: Any?) -> UIViewController {
        let homeDependencies = HomeDependencies(url, baseFlowDelegate, StructuralDependencyProvider.shared, customModuleAnalytics as? HomeAnalyticsProtocol, value)
        
        return HomeLauncher.start(with: homeDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        return "home"
    }
    
    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .profile:
            AppNavigation.shared.push(journey, from: viewController)
            break
            
        case .login:
            AppNavigation.shared.show([.login], from: viewController, animated: false)
            isUserLoggedIn = false
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
    }
}

extension StructuralDependencyProvider: HomeStructuralDependencies {}
