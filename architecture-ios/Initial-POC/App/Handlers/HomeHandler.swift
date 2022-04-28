//
//  HomeHandler.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Home

class HomeHandler: ModuleHandler {
    var baseFlowDataSource: BaseFlowDataSource?
    
    var baseFlowDelegate: BaseFlowDelegate?
    
    var appNavigation: AppNavigationProtocol
    
    init(appNavigation: AppNavigationProtocol) {
        self.appNavigation = appNavigation
    }
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let homeDependencies = HomeDependencies(url, self, DIContainer.shared, customModuleAnalytics as? HomeAnalyticsProtocol, value)
        
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
        case .profile:
            appNavigation.push(journey, from: viewController)
            break
            
        case .login:
            appNavigation.show(journeys: [.welcome, .login], fromCurrentViewController: viewController, animated: false)
            isUserLoggedIn = false
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: appNavigation as! BaseFlowDelegate, appNavigation as! BaseFlowDataSource, analytics, subJourney, nil)
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?) {
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
}

extension DIContainer: HomeStructuralDependencies {}

extension HomeHandler: HomeFlowDelegate {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?) {
        baseFlowDelegate?.perform(.goTo(.profile, currentJourney: .home), in: controller, with: value)
    }
    
    func goToLogin(from flow: Flow, in controller: UIViewController, with value: Any?) {
        baseFlowDelegate?.perform(.finishCurrentAndGoTo(.login, currentJourney: .home), in: controller, with: value)
    }
}
