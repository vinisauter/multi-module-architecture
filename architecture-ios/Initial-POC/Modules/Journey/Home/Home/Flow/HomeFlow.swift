//
//  HomeFlow.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

protocol HomeFlowProtocol: AnyObject {
    var factory: HomeViewControllerFactory { get }
    var baseFlowDelegate: BaseFlowDelegate? { get set }
    func start(useCase: HomeUseCaseProtocol, analytics: HomeAnalyticsProtocol) -> UIViewController
}

class HomeFlow: HomeFlowProtocol {
    var factory: HomeViewControllerFactory
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    
    init(factory: HomeViewControllerFactory) {
        self.factory = factory
    }
    
    func start(useCase: HomeUseCaseProtocol, analytics: HomeAnalyticsProtocol) -> UIViewController {
        return factory.makeHomeIndexViewController()
    }
}

// MARK: - HomeIndexFlowDelegate

extension HomeFlow: HomeIndexFlowDelegate {
    func logout(in controller: HomeIndexViewController) {
        baseFlowDelegate?.go(to: .login, from: .home, in: controller, with: nil)
        baseFlowDelegate?.didFinish(.home, in: controller, with: nil)
    }
    
    func openProfile(in controller: HomeIndexViewController) {
        baseFlowDelegate?.go(to: .profile, from: .home, in: controller, with: nil)
    }
}
