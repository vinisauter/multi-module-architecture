//
//  AppNavigation.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import UIKit

public final class AppNavigation {
    public var navigationController: UINavigationController = UINavigationController()
    private var currentJourney: Journey = .unkown
    private var rawDeeplink: String?
    private var handlers: Dictionary<Journey, ModuleHandler> = [:]
    
    // MARK: - Initializer
    
    public init () {}
    
    // MARK: - Action Functions
    
    func setRootViewController(_ viewController: UIViewController, from currentViewController: UIViewController? = nil, animated: Bool = false) {
        if currentViewController?.navigationController != navigationController { currentViewController?.dismiss(animated: animated) }
        
        if let rootVC = navigationController.viewControllers.first, type(of: rootVC) == type(of: viewController) {
            popToViewControllerWithType(type(of: viewController))
        } else {
            navigationController.setViewControllers([viewController], animated: animated)
        }
    }
    
    func push(_ viewController: UIViewController, from currrentViewController: UIViewController? = nil, animated: Bool = true) {
        if currrentViewController?.navigationController != navigationController { currrentViewController?.dismiss(animated: animated) }
        
        if let currrentViewController = currrentViewController { popToViewControllerWithType(type(of: currrentViewController)) }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func push(journey: Journey, fromCurrentViewController currentViewController: UIViewController? = nil, withValue value: Any? = nil, animated: Bool) {
        push(start(journey: journey, fromCurrentJourney: nil, withSubJourney: nil, url: nil, baseFlowDelegate: self, baseFlowDataSource: self, customModuleAnalytics: nil, andValue: value), animated: animated)
    }
    
    private func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    @discardableResult private func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> Array<UIViewController>? {
        return navigationController.popToViewControllerWithType(T.self)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    @discardableResult public func resolve(_ rawDeeplink: String?) -> Bool {
        guard let rawDeeplink = rawDeeplink, let deeplink = getDeeplink(from: rawDeeplink), let destinationJourney = deeplink.value, let url = deeplink.url, let handler = getHandler(from: destinationJourney) else { return false }
        
        guard handler.canStart() else {
            self.rawDeeplink = rawDeeplink
            return false
        }

        self.rawDeeplink = nil

        if currentJourney != destinationJourney {
            let deeplinkNavigation = UINavigationController(rootViewController: start(journey: destinationJourney, fromCurrentJourney: nil, withSubJourney: nil, url: url, baseFlowDelegate: self, baseFlowDataSource: self, customModuleAnalytics: nil, andValue: nil))
            deeplinkNavigation.modalPresentationStyle = .fullScreen
            present(deeplinkNavigation)
            return true
        } else {
            // TODO: Deeplink
            return true
        }
    }
    
    public func resolveDeeplinkIfNeeded() {
        resolve(rawDeeplink)
    }
    
    public func register(jorneys: Array<Journey>, withStater stater: ModuleHandler) {
        jorneys.forEach{ [weak self] jorney in self?.handlers[jorney] = stater }
    }
    
    public func unregister(jorneys: Array<Journey>) {
        jorneys.forEach{ journey in
            handlers.removeValue(forKey: journey)
        }
    }
    
    public func getHandler(from jorney: Journey) -> ModuleHandler? {
        return handlers[jorney]
    }
    
    public func start(journey: Journey, fromCurrentJourney currentJourney: Journey? = nil, withSubJourney subJourney: Journey? = nil, url: URL? = nil, baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource, customModuleAnalytics: Any? = nil, andValue value: Any? = nil) -> UIViewController {
        
        guard let handler = getHandler(from: journey) else { return UIViewController() }

        self.currentJourney = currentJourney ?? journey
        
        return handler.launch(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value)
    }
    
    public func show(journeys: Array<Journey>, fromCurrentViewController currentViewController: UIViewController? = nil, withValue value: Dictionary<Journey, Any>? = nil, animated: Bool) {
        let journeysControllers = journeys.compactMap{ [weak self] journey -> UIViewController? in
            guard let self = self else { return UIViewController() }
            let firstModuleVC = self.start(journey: journey, fromCurrentJourney: nil, withSubJourney: nil, url: nil, baseFlowDelegate: self, baseFlowDataSource: self, customModuleAnalytics: nil, andValue: value?[journey])
            firstModuleVC.loadViewIfNeeded()
            return firstModuleVC
        }
        
        if journeysControllers.count > 1 {
            if currentViewController?.navigationController != navigationController { currentViewController?.dismiss(animated: animated) }
            navigationController.setViewControllers(journeysControllers, animated: animated)
        } else if !journeysControllers.isEmpty {
            setRootViewController(journeysControllers.first!, from: currentViewController, animated: animated)
        }
    }
    
    private func getDeeplink(from rawDeeplink: String) -> Deeplink<Journey>? {
        guard  let url = URL(string: rawDeeplink),
               let host = url.host,
               let jorneyModule = getJorneyModule(from: host)
               else { return nil }

        return .init(value: jorneyModule, url: url)
    }
    
    private func getJorneyModule(from name: String) -> Journey? {
        return handlers.first{ $0.value.getName().lowercased() == name.lowercased() && !$0.key.isSubJourney }?.key
    }
}

// MARK: - BaseFlowDelegate

extension AppNavigation: BaseFlowDelegate {
    public func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?) {
        switch action {
        case .finish(let journey):
            handleFinish(journey, in: viewController, with: value)
            break
            
        case .goTo(let destinationJourney, let currentJourney):
            handleGo(to: destinationJourney, from: currentJourney, in: viewController, with: value)
            break
            
        case .finishCurrentAndGoTo(let destinationJourney, let currentJourney):
            handleGo(to: destinationJourney, from: currentJourney, in: viewController, with: value)
            handleFinish(currentJourney, in: viewController, with: value)
            
            break
        }
    }
    
    private func handleGo(to destinationJourney: Journey, from currentJourney: Journey, in viewController: UIViewController, with value: Any?) {
        guard let handler = getHandler(from: currentJourney) else { return }
        handler.handleGo(to: destinationJourney, in: viewController, with: value, andAppNavigation: self)
    }
    
    private func handleFinish(_ jorney: Journey, in viewController: UIViewController, with value: Any?) {
        guard let handler = getHandler(from: jorney) else { return }
        handler.handleFinish(in: viewController, with: value, andAppNavigation: self)
    }
}

// MARK: - BaseFlowDataSource

extension AppNavigation: BaseFlowDataSource {
    public func get(_ journey: Journey, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController {
        guard let handler = getHandler(from: journey) else { return UIViewController() }
        return handler.launch(from: nil, with: baseFlowDelegate, self, customAnalytics, journey, nil)
    }
}
