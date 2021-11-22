//
//  AppNavigation.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

var isUserLoggedIn: Bool = false

class AppNavigation {
    static let shared: AppNavigation = AppNavigation()
    
    let navigationController: UINavigationController = UINavigationController()
    private var currentJourney: JourneyModule = .welcome
    private var deeplink: String?
    
    // MARK: - Initializer
    
    private init () {}
    
    // MARK: - Action Functions
    
    func setRootViewController(_ viewController: UIViewController, from currrentViewController: UIViewController? = nil, animated: Bool = false) {
        if currrentViewController?.navigationController != navigationController { currrentViewController?.dismiss(animated: true) }
        
        if let rootVC = navigationController.viewControllers.first, type(of: rootVC) == type(of: viewController) {
            popToViewControllerWithType(type(of: viewController))
        } else {
            navigationController.setViewControllers([viewController], animated: animated)
        }
    }
    
    func push(_ viewController: UIViewController, from currrentViewController: UIViewController? = nil, animated: Bool = true) {
        if currrentViewController?.navigationController != navigationController { currrentViewController?.dismiss(animated: true) }
        
        popToViewControllerWithType(type(of: currrentViewController ?? UIViewController()))
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
    
    func resolve(_ deeplink: String?) {
        guard let deeplink = deeplink else { return }
        
        let (destinationJourney, url) = JourneyModule.from(deeplink)
        
        guard !destinationJourney.shouldBeLogInToOpen || isUserLoggedIn else {
            self.deeplink = deeplink
            return
        }
        
        self.deeplink = nil
        
        if currentJourney != destinationJourney {
            let deeplinkNavigation = UINavigationController(rootViewController: start(destinationJourney, with: url, baseFlowDelegate: self, baseFlowDataSource: self))
            deeplinkNavigation.modalPresentationStyle = .fullScreen
            present(deeplinkNavigation)
        }
    }
    
    func resolveDeeplinkIfNeeded() {
        resolve(deeplink)
    }
    
    func start(_ journey: JourneyModule, to subJourney: JourneyModule? = nil, from currentJourney: JourneyModule? = nil, with url: URL? = nil, baseFlowDelegate: BaseFlowDelegate = AppNavigation.shared, baseFlowDataSource: BaseFlowDataSource = AppNavigation.shared, moduleAnalytics: JourneyModuleAnalyticsProtocol? = nil) -> UIViewController {
        self.currentJourney = currentJourney == nil ? journey : currentJourney!
        switch journey {
        case .welcome: return UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
        case .login, .forgotPassword: return startLogin(from: url, baseFlowDelegate: baseFlowDelegate, customLoginAnalytics: moduleAnalytics, subJourney: subJourney)
        case .home: return startHome(from: url, baseFlowDelegate: baseFlowDelegate, customHomeAnalytics: moduleAnalytics, subJourney: subJourney)
        case .profile: return startProfile(from: url, baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource, customProfileAnalytics: moduleAnalytics, subJourney: subJourney)
        }
    }
    
    func set(_ journeys: Array<JourneyModule>, animated: Bool) {
        let journeysControllers = journeys.compactMap{ [weak self] journey -> UIViewController? in
            let firstModuleVC = self?.start(journey)
            firstModuleVC?.loadViewIfNeeded()
            return firstModuleVC
        }
        
        navigationController.setViewControllers(journeysControllers, animated: animated)
    }
}

// MARK: - BaseFlowDelegate

extension AppNavigation: BaseFlowDelegate {
    func go(to destinationJourney: JourneyModule, from currentJourney: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch currentJourney {
        case .welcome: break
        case .login, .forgotPassword:
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
    func get(_ journey: JourneyModule, from currentJourney: JourneyModule, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        switch journey {
        case .welcome: return start(.welcome)
        case .login, .forgotPassword: return handleGetLoginFlow(from: currentJourney, to: journey, with: baseFlowDelegate, analytics: customAnalytics)
        case .home: return handleGetHomeFlow(from: currentJourney, to: journey, with: baseFlowDelegate, analytics: customAnalytics)
        case .profile: return handleGetProfileFlow(from: currentJourney, to: journey, with: baseFlowDelegate, analytics: customAnalytics)
        }
    }
}
