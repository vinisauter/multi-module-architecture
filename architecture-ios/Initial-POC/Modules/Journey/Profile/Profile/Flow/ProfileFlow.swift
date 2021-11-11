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
    var delegate: ProfileFlowDelegate? { get set }
    var dataSource: ProfileFlowDataSource? { get set }
    func start(useCase: ProfileUseCaseProtocol, analytics: ProfileAnalyticsProtocol) -> UIViewController
}


public protocol ProfileFlowDelegate: AnyObject {
    func goToHomeFromProfile(in controller: UIViewController)
}

public protocol ProfileFlowDataSource: AnyObject {
    func getLogin(from profileFlow: BaseFlowDelegate) -> UIViewController
}

class ProfileFlow: ProfileFlowProtocol {
    var factory: ProfileViewControllerFactory
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    weak var delegate: ProfileFlowDelegate?
    weak var dataSource: ProfileFlowDataSource?
    
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
        delegate?.goToHomeFromProfile(in: controller)
        baseFlowDelegate?.didFinish(.profile, in: controller, with: nil)
    }
    
    func callLogin(in controller: ProfileHomeViewController) {
        guard let loginVC = dataSource?.getLogin(from: self) else { return }
        
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
