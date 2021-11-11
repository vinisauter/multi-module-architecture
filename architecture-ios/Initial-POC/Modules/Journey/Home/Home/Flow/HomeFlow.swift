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
    var delegate: HomeFlowDelegate? { get set }
    var dataSource: HomeFlowDataSource? { get set }
    func start(useCase: HomeUseCaseProtocol, analytics: HomeAnalyticsProtocol) -> UIViewController
}

public protocol HomeFlowDelegate: AnyObject {
    func goToLoginFromHome()
}

public protocol HomeFlowDataSource: AnyObject {
    func getProfile() -> UIViewController
}

class HomeFlow: HomeFlowProtocol {
    var factory: HomeViewControllerFactory
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    weak var delegate: HomeFlowDelegate?
    weak var dataSource: HomeFlowDataSource?
    
    init(factory: HomeViewControllerFactory) {
        self.factory = factory
    }
    
    func start(useCase: HomeUseCaseProtocol, analytics: HomeAnalyticsProtocol) -> UIViewController {
        return factory.makeHomeIndexViewController()
    }
}

// MARK: - LoginViewControllerFlowDelegate

extension HomeFlow: HomeIndexFlowDelegate {
    func logout(in controller: HomeIndexViewController) {
        delegate?.goToLoginFromHome()
    }
    
    func openProfile(in controller: HomeIndexViewController) {
        guard let profileVC =  dataSource?.getProfile() else { return }
        controller.show(profileVC, sender: nil)
    }
}
