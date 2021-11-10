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
    
    func startLogin(baseFlowDelegate: BaseFlowDelegate? = nil, loginFlowDelegate: LoginFlowDelegate? = nil) -> UIViewController {
        return LoginLauncher.start(baseFlowDelegate: baseFlowDelegate, loginFlowDelegate: loginFlowDelegate, httpClient: DependencyProvider.networking)
    }
    
    func startHome(baseFlowDelegate: BaseFlowDelegate? = nil, homeFlowDelegate: HomeFlowDelegate? = nil, homeFlowDataSource: HomeFlowDataSource? = nil) -> UIViewController {
        return HomeLauncher.start(baseFlowDelegate: baseFlowDelegate, homeFlowDelegate: homeFlowDelegate, homeFlowDataSource: homeFlowDataSource, httpClient: DependencyProvider.networking)
    }
    
    func startProfile(baseFlowDelegate: BaseFlowDelegate? = nil, profileFlowDataSource: ProfileFlowDataSource? = nil, profileFlowDelegate: ProfileFlowDelegate? = nil) -> UIViewController {
        return ProfileLauncher.start(baseFlowDelegate: baseFlowDelegate, profileFlowDataSource: profileFlowDataSource, profileFlowDelegate: profileFlowDelegate, httpClient: DependencyProvider.networking)
    }
}


// MARK: - LoginFlow

extension AppNavigation: LoginFlowDelegate {
    func goToHomeFromLogin(in controller: UIViewController) {
        setRootViewController(startHome(homeFlowDelegate: self, homeFlowDataSource: self), animated: true)
    }
}

// MARK: - HomeFlow

extension AppNavigation: HomeFlowDelegate {
    func goToLogin() {
        setRootViewController(startLogin(loginFlowDelegate: self))
    }
}

extension AppNavigation: HomeFlowDataSource {
    func getProfile() -> UIViewController {
        return startProfile(profileFlowDataSource: self, profileFlowDelegate: self)
    }
}

// MARK: - ProfileFlow


extension AppNavigation: ProfileFlowDelegate {
    func goToHomeFromProfile(in controller: UIViewController) {
        navigationController.popToViewControllerWithType(HomeIndexViewController.self)
    }
}

extension AppNavigation: ProfileFlowDataSource {
    func getLogin(from profileFlow: BaseFlowDelegate) -> UIViewController {
        return startLogin(baseFlowDelegate: profileFlow)
    }
}
