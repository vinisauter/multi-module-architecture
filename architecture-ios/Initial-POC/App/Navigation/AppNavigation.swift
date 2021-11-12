//
//  AppNavigation.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

class AppNavigation {
    static let shared: AppNavigation = AppNavigation()
    
    let navigationController: UINavigationController = UINavigationController()
    
    // MARK: - Initializer
    
    private init () {}
    
    // MARK: - Action Functions
    
    func setRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        navigationController.setViewControllers([viewController], animated: animated)
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    @discardableResult func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> Array<UIViewController>? {
        return navigationController.popToViewControllerWithType(T.self)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    func start(from deeplink: String, with baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource) -> UIViewController {
        let journey = JourneyModule.from(deeplink)
        
        switch journey {
        case .unknown: return UIViewController()
        case .login: return startLogin(baseFlowDelegate: baseFlowDelegate)
        case .home: return startHome(baseFlowDelegate: baseFlowDelegate)
        case .profile: return startProfile(baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource)
        }
    }
}

// MARK: - BaseFlowDelegate

extension AppNavigation: BaseFlowDelegate {
    func go(to destinationJourney: JourneyModule, from currentJourney: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch currentJourney {
        case .unknown: break
        case .login:
            handleLoginFlowGo(to: destinationJourney, in: viewController, with: value)
            break
            
        case .home:
            handleHomeFlowGo(to: destinationJourney, in: viewController, with: value)
            break
            
        case .profile:
            handleProfileFlowGo(to: destinationJourney, in: viewController, with: value)
            break            
        }
    }
}

// MARK: - BaseFlowDataSource

extension AppNavigation: BaseFlowDataSource {
    func get(_ journey: JourneyModule, from currentJourney: BaseFlowDelegate) -> UIViewController {
        switch journey {
        case .unknown: return UIViewController()
        case .login: return handleGetLoginFlow(from: currentJourney)
        case .home: return handleGetHomeFlow(from: currentJourney)
        case .profile: return handleGetProfileFlow(from: currentJourney)
        }
    }
}
