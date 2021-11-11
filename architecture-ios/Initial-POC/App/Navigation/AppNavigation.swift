//
//  AppNavigation.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core
import Login
import Home
import Profile

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
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    // MARK: - Start Functions
    
    func startLogin(baseFlowDelegate: BaseFlowDelegate? = nil) -> UIViewController {
        return LoginLauncher.start(baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking)
    }
    
    func startHome(baseFlowDelegate: BaseFlowDelegate? = nil) -> UIViewController {
        return HomeLauncher.start(baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking)
    }
    
    func startProfile(baseFlowDelegate: BaseFlowDelegate? = nil, baseFlowDataSource: BaseFlowDataSource? = nil) -> UIViewController {
        return ProfileLauncher.start(baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource, httpClient: DependencyProvider.networking)
    }
}

// MARK: - BaseFlowDelegate

extension AppNavigation: BaseFlowDelegate {
    func go(to destinationJourney: JourneyModule, from currentJourney: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch currentJourney {
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
        case .login:
            return handleGetLoginFlow(from: currentJourney)
        
        case .home:
            return handleGetHomeFlow(from: currentJourney)
            
        case .profile:
            return handleGetProfileFlow(from: currentJourney)
        }
    }
}
