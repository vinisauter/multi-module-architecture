//
//  LoginFlow.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

protocol LoginFlowProtocol: AnyObject {
    var factory: LoginViewControllerFactory { get }
    var baseFlowDelegate: BaseFlowDelegate? { get set }
    var delegate: LoginFlowDelegate? { get set }
    func start(useCase: LoginUseCaseProtocol, analytics: LoginAnalyticsProtocol) -> UIViewController
}

public protocol LoginFlowDelegate: AnyObject {
    func goToHomeFromLogin(in controller: UIViewController)
}

class LoginFlow: LoginFlowProtocol {
    var factory: LoginViewControllerFactory
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    weak var delegate: LoginFlowDelegate?
    
    init(factory: LoginViewControllerFactory) {
        self.factory = factory
    }
    
    func start(useCase: LoginUseCaseProtocol, analytics: LoginAnalyticsProtocol) -> UIViewController {
        return factory.makeLoginViewController()
    }
}

// MARK: - LoginViewControllerFlowDelegate

extension LoginFlow: LoginIndexFlowDelegate {
    func onLoginSuccess(in controller: LoginIndexViewController) {
        delegate?.goToHomeFromLogin(in: controller)
        baseFlowDelegate?.didFinish(.login, in: controller, with: nil)
    }
}
