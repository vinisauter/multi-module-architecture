//
//  HomeHandler.swift
//  LoginDemo
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import UIKit
import Core
import Home

class HomeHandler: ModuleHandler {
    private weak var baseFlowDelegate: BaseFlowDelegate?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let homeDependencies = HomeDependencies(url, self, StructuralDependencyProvider.shared, customModuleAnalytics as? HomeAnalyticsProtocol, value)
        
        return HomeLauncher.start(with: homeDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        return Journey.home.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .login:
            AppNavigation.shared.show([.login], from: viewController, animated: false)
            isUserLoggedIn = false
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
    }
}

extension StructuralDependencyProvider: HomeStructuralDependencies {}

extension HomeHandler: HomeFlowDelegate {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?) {}
    
    func goToLogin(from flow: Flow, in controller: UIViewController, with value: Any?) {
        baseFlowDelegate?.perform(.finishCurrentAndGoTo(.login, currentJourney: .home), in: controller, with: value)
    }
}

