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
    var appNavigation: AppNavigation?
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?
        
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, value: Any?, appNavigation: AppNavigation, andCompletionHandler completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?) -> UIViewController {
        self.appNavigation = appNavigation
        self.completionHandler = completion
        let homeDependencies = HomeDependencies(url, self, DIContainer.shared, customAnalytics as? HomeAnalyticsProtocol, value)
        
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
            appNavigation?.push(journey: journey, fromCurrentViewController: viewController, animated: true)
            break
            
        case .login:
            appNavigation?.show(journeys: [.welcome, .login], fromCurrentViewController: viewController, withValue: nil, animated: false)
            isUserLoggedIn = false
            break
            
        default: break
        }
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?) {
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
}

extension DIContainer: HomeStructuralDependencies {}

extension HomeHandler: HomeFlowDelegate {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?) {
        appNavigation?.perform(.goTo(.profile, currentJourney: .home), in: controller, with: value)
    }
    
    func goToLogin(from flow: Flow, in controller: UIViewController, with value: Any?) {
        appNavigation?.perform(.finishCurrentAndGoTo(.login, currentJourney: .home), in: controller, with: value)
    }
}
