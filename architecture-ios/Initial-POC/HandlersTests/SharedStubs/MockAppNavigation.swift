//
//  MockAppNavigation.swift
//  HandlersTests
//
//  Created by Nykolas Mayko Maia Barbosa on 27/01/22.
//

import UIKit
import Core

class MockAppNavigation: AppNavigationProtocol {
    private var handlers: Dictionary<Journey, ModuleHandler> = [:]
    
    func push(_ journey: Journey, from currentViewController: UIViewController?, animated: Bool) {}
    
    func popViewController(animated: Bool) {}
    
    func popToViewControllerWithType<T>(_ type: T.Type) -> Array<UIViewController>? where T : UIViewController {
        return [UIViewController]()
    }
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {}
    
    func resolve(_ rawDeeplink: String?) -> Bool { return true }
    
    func resolveDeeplinkIfNeeded() {}
    
    func register(_ jorneys: Array<Journey>, with stater: ModuleHandler) {
        jorneys.forEach{ [weak self] jorney in self?.handlers[jorney] = stater }
    }
    
    func getHandler(from jorney: Journey) -> ModuleHandler? { return handlers[jorney] }
    
    func start(_ journey: Journey, to subJourney: Journey?, from currentJourney: Journey?, with url: URL?, baseFlowDelegate: BaseFlowDelegate?, baseFlowDataSource: BaseFlowDataSource?, customModuleAnalytics: Any?, value: Any?) -> UIViewController { return getHandler(from: journey)?.start(from: nil, with: baseFlowDelegate ?? MockBaseFlowDelegate(), baseFlowDataSource ?? MockBaseFlowDataSource(), customModuleAnalytics, subJourney, value) ?? UIViewController() }
    
    func show(_ journeys: Array<Journey>, from currentViewController: UIViewController?, animated: Bool) {}
}
