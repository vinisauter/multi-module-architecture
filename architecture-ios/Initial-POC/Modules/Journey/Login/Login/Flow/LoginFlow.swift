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
    func start(useCase: LoginUseCaseProtocol, analytics: LoginAnalyticsProtocol) -> UIViewController
}

class LoginFlow: LoginFlowProtocol {
    var factory: LoginViewControllerFactory
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    
    init(factory: LoginViewControllerFactory) {
        self.factory = factory
    }
    
    func start(useCase: LoginUseCaseProtocol, analytics: LoginAnalyticsProtocol) -> UIViewController {
        return factory.makeLoginViewController()
    }
}

// MARK: - LoginIndexFlowDelegate

extension LoginFlow: LoginIndexFlowDelegate {
    func onLoginSuccess(in controller: LoginIndexViewController) {
        baseFlowDelegate?.go(to: .home, from: .login, in: controller, with: nil)
        baseFlowDelegate?.didFinish(.login, in: controller, with: nil)
    }
}
