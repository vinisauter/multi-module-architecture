//
//  AppNavigation.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import UIKit

public protocol AppNavigationProtocol {
    func register(jorneys: Array<Journey>, withStater stater: ModuleHandlerProtocol)
    func resolve(_ rawDeeplink: String?) -> Bool
    func resolveDeeplinkIfNeeded()
    func push(journey: Journey, fromCurrentViewController currentViewController: UIViewController?, withValue value: Any?, animated: Bool)
    func show(journeys: Array<Journey>, fromCurrentViewController currentViewController: UIViewController?, withValue value: Dictionary<Journey, Any?>?, animated: Bool)
    func start(journey: Journey, fromCurrentJourney currentJourney: Journey?, withSubJourney subJourney: Journey?, url: URL?, customAnalytics: Any?, value: Any?, andCompletion completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?) -> UIViewController
}

public final class AppNavigation: AppNavigationProtocol, AppNavigationDataSource, ModuleHandlerNavigationDelegate {
    public var navigationController: UINavigationController = UINavigationController()
    private var currentJourney: Journey = .unkown
    private var rawDeeplink: String?
    private var handlers: Dictionary<Journey, ModuleHandlerProtocol> = [:]
    
    // MARK: - Initializer
    
    public init () {}
    
    // MARK: - Public Functions
    
    @discardableResult public func resolve(_ rawDeeplink: String?) -> Bool {
        guard let rawDeeplink = rawDeeplink, let deeplink = getDeeplink(from: rawDeeplink), let destinationJourney = deeplink.value, let url = deeplink.url, let handler = getHandler(from: destinationJourney) else { return false }
        
        guard handler.canStart() else {
            self.rawDeeplink = rawDeeplink
            return false
        }

        self.rawDeeplink = nil

        if currentJourney != destinationJourney {
            let deeplinkNavigation = UINavigationController(rootViewController: start(journey: destinationJourney, url: url))
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
    
    public func register(jorneys: Array<Journey>, withStater stater: ModuleHandlerProtocol) {
        jorneys.forEach{ [weak self] jorney in self?.handlers[jorney] = stater }
    }
    
    public func unregister(jorneys: Array<Journey>) {
        jorneys.forEach{ journey in
            handlers.removeValue(forKey: journey)
        }
    }
    
    public func start(journey: Journey, fromCurrentJourney currentJourney: Journey? = nil, withSubJourney subJourney: Journey? = nil, url: URL? = nil, customAnalytics: Any? = nil, value: Any? = nil, andCompletion completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)? = nil) -> UIViewController {
        guard let handler = getHandler(from: journey) else { return UIViewController() }
        
        self.currentJourney = currentJourney ?? journey
        
        handler.completionHandler = completion
        handler.navigationDelegate = self
        handler.navigationDataSource = self
        
        return handler.launch(fromURL: url, withCustomAnalytics: customAnalytics, subJourney: subJourney, andValue: value)
    }
    
    public func push(journey: Journey, fromCurrentViewController currentViewController: UIViewController? = nil, withValue value: Any? = nil, animated: Bool) {
        push(start(journey: journey, value: value), animated: animated)
    }
    
    public func show(journeys: Array<Journey>, fromCurrentViewController currentViewController: UIViewController? = nil, withValue value: Dictionary<Journey, Any?>? = nil, animated: Bool) {
        let journeysControllers = journeys.compactMap{ [weak self] journey -> UIViewController? in
            guard let self = self else { return UIViewController() }
            let firstModuleVC = self.start(journey: journey, value: value?[journey] as Any?)
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
    
    public func get(_ journey: Journey, customAnalytics: Any?, completion: @escaping (BaseFlowDelegateAction, UIViewController, Any?) -> Void) -> UIViewController {
        return start(journey: journey, fromCurrentJourney: nil, withSubJourney: journey.isSubJourney ? journey : nil, url: nil, customAnalytics: customAnalytics, value: nil, andCompletion: completion)
    }
    
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
    
    // MARK: - Private Functions
    
    private func setRootViewController(_ viewController: UIViewController, from currentViewController: UIViewController? = nil, animated: Bool = false) {
        if currentViewController?.navigationController != navigationController { currentViewController?.dismiss(animated: animated) }
        
        if let rootVC = navigationController.viewControllers.first, type(of: rootVC) == type(of: viewController) {
            popToViewControllerWithType(type(of: viewController))
        } else {
            navigationController.setViewControllers([viewController], animated: animated)
        }
    }
    
    private func push(_ viewController: UIViewController, from currrentViewController: UIViewController? = nil, animated: Bool = true) {
        if currrentViewController?.navigationController != navigationController { currrentViewController?.dismiss(animated: animated) }
        
        if let currrentViewController = currrentViewController { popToViewControllerWithType(type(of: currrentViewController)) }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    @discardableResult private func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> Array<UIViewController>? {
        return navigationController.popToViewControllerWithType(T.self)
    }
    
    private func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    
    
    private func handleGo(to destinationJourney: Journey, from currentJourney: Journey, in viewController: UIViewController, with value: Any?) {
        guard let handler = getHandler(from: currentJourney) else { return }
        if let completionHandler = handler.completionHandler {
            return completionHandler(.goTo(destinationJourney, currentJourney: currentJourney), viewController, value)
        }
        handler.handleGo(to: destinationJourney, in: viewController, with: value, andAppNavigation: self)
    }
    
    private func handleFinish(_ jorney: Journey, in viewController: UIViewController, with value: Any?) {
        guard let handler = getHandler(from: jorney) else { return }
        if let completionHandler = handler.completionHandler {
            return completionHandler(.finish(jorney), viewController, value)
        }
        handler.handleFinish(in: viewController, with: value, andAppNavigation: self)
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
    
    private func getHandler(from jorney: Journey) -> ModuleHandlerProtocol? {
        return handlers[jorney]
    }
}
