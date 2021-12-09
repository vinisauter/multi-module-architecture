//
//  AppNavigation.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import UIKit

public final class AppNavigation {
    public static let shared: AppNavigation = AppNavigation()
    
    public let navigationController: UINavigationController = UINavigationController()
    private var currentJourney: Journey?
    private var rawDeeplink: String?
    private var handlers: Dictionary<Journey, ModuleHandler> = [:]
    
    // MARK: - Initializer
    
    private init () {}
    
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
    
    public func push(_ journey: Journey, from currentViewController: UIViewController?, animated: Bool = true) {
        push(start(journey), from: currentViewController, animated: animated)
    }
    
    public func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    @discardableResult public func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> Array<UIViewController>? {
        return navigationController.popToViewControllerWithType(T.self)
    }
    
    public func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
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
            let deeplinkNavigation = UINavigationController(rootViewController: start(destinationJourney, with: url))
            deeplinkNavigation.modalPresentationStyle = .fullScreen
            present(deeplinkNavigation)
            return true
        } else {
            // TODO: Push when the module is started
            return false
        }
    }
    
    public func resolveDeeplinkIfNeeded() {
        resolve(rawDeeplink)
    }
    
    public func register(_ jorneys: Array<Journey>, with stater: ModuleHandler) {
        jorneys.forEach{ [weak self] jorney in self?.handlers[jorney] = stater }
    }
    
    public func getHandler(from jorney: Journey) -> ModuleHandler? {
        return handlers[jorney]
    }
    
    public func start(_ journey: Journey, to subJourney: Journey? = nil, from currentJourney: Journey? = nil, with url: URL? = nil, baseFlowDelegate: BaseFlowDelegate = AppNavigation.shared, baseFlowDataSource: BaseFlowDataSource = AppNavigation.shared, customModuleAnalytics: Any? = nil, value: Any? = nil) -> UIViewController {
        
        guard let handler = getHandler(from: journey) else { return UIViewController() }

        self.currentJourney = currentJourney == nil ? journey : currentJourney!
        
        return handler.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value)
    }
    
    public func show(_ journeys: Array<Journey>, from currentViewController: UIViewController? = nil, animated: Bool) {
        let journeysControllers = journeys.compactMap{ [weak self] journey -> UIViewController? in
            let firstModuleVC = self?.start(journey)
            firstModuleVC?.loadViewIfNeeded()
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
        return handlers.first{ $0.value.getName().lowercased() == name.lowercased() }?.key
    }
}

// MARK: - BaseFlowDelegate

extension AppNavigation: BaseFlowDelegate {
    public func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?) {
        switch action {
        case .finish(let journey):
            debugPrint("====== AppNavigation didFinish: \(journey.rawValue)")
            break
            
        case .goTo(let destinationJourney, let currentJourney):
            handleGo(to: destinationJourney, from: currentJourney, in: viewController, with: value)
            break
            
        case .finishCurrentAndGoTo(let destinationJourney, let currentJourney):
            debugPrint("====== AppNavigation didFinish: \(currentJourney.rawValue)")
            handleGo(to: destinationJourney, from: currentJourney, in: viewController, with: value)
            break
        }
    }
    
    private func handleGo(to destinationJourney: Journey, from currentJourney: Journey, in viewController: UIViewController, with value: Any?) {
        guard let handler = getHandler(from: currentJourney) else { return }
        handler.handleGo(to: destinationJourney, in: viewController, with: value)
    }
}

// MARK: - BaseFlowDataSource

extension AppNavigation: BaseFlowDataSource {
    public func get(_ journey: Journey, from currentJourney: Journey, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController {
        guard let handler = getHandler(from: journey) else { return UIViewController() }
        return handler.handleGet(from: currentJourney, to: journey, with: baseFlowDelegate, analytics: customAnalytics)
    }
}
