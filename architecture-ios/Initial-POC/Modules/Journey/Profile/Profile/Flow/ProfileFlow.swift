//
//  ProfileFlow.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

public protocol ProfileFlowProtocol: AnyObject {
    var factory: ProfileViewControllerFactory { get }
    var baseFlowDelegate: BaseFlowDelegate? { get set }
    var baseFlowDataSource: BaseFlowDataSource? { get set }
    func start(useCase: ProfileUseCaseProtocol, analytics: ProfileAnalyticsProtocol) -> UIViewController
}

class ProfileFlow: ProfileFlowProtocol {
    var factory: ProfileViewControllerFactory
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    weak var baseFlowDataSource: BaseFlowDataSource?
    
    init(factory: ProfileViewControllerFactory) {
        self.factory = factory
    }
    
    func start(useCase: ProfileUseCaseProtocol, analytics: ProfileAnalyticsProtocol) -> UIViewController {
        return factory.makeProfileHomeViewController()
    }
}

// MARK: - LoginViewControllerFlowDelegate

extension ProfileFlow: ProfileHomeFlowDelegate {
    func goToHome(in controller: ProfileHomeViewController) {
        baseFlowDelegate?.go(to: .home, from: .profile, in: controller, with: nil)
        baseFlowDelegate?.didFinish(.profile, in: controller, with: nil)
    }
    
    func callLogin(in controller: ProfileHomeViewController) {
        guard let loginVC = baseFlowDataSource?.get(.login, from: self) else { return }
        
        loginVC.modalPresentationStyle = .fullScreen
        
        controller.present(loginVC, animated: true)
    }
}

// MARK: - BaseFlowDelegate

extension ProfileFlow: BaseFlowDelegate {
    func didFinish(_ feature: JourneyModule, in viewController: UIViewController, with value: Any?) {
        viewController.dismiss(animated: true)
    }
}
