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
    var deeplink: Deeplink<LoginDeeplink>? { get set }
    func start() -> UIViewController
}

class LoginFlow: LoginFlowProtocol, Deeplinkable {
    var factory: LoginViewControllerFactory
    
    var deeplink: Deeplink<LoginDeeplink>?
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    
    init(factory: LoginViewControllerFactory, deeplink: Deeplink<LoginDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeLoginViewController(isIndex: true)
    }
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink, let screen = deeplink.value, let url = deeplink.url else { return }
        self.deeplink = nil
        
        switch screen {
        case .index: break
        case .forgotPassword:
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let userName = urlComponents?.queryItems?.first{ $0.name == "userName" }
            debugPrint(userName ?? "")
            controller.show(factory.makeForgotPasswordViewController(), sender: nil)
            break
        }
    }
}

// MARK: - LoginIndexFlowDelegate

extension LoginFlow: LoginIndexFlowDelegate {
    func onForgotPasswordClick(in controller: LoginIndexViewController) {
        controller.show(factory.makeForgotPasswordViewController(), sender: nil)
    }
    
    func onLoginSuccess(in controller: LoginIndexViewController) {
        baseFlowDelegate?.go(to: .home, from: .login, in: controller, with: nil)
        baseFlowDelegate?.didFinish(.login, in: controller, with: nil)
    }
}

// MARK: - ForgotPasswordFlowDelegate

extension LoginFlow: ForgotPasswordFlowDelegate {
    func onChangePasswordSuccess(in controller: ForgotPasswordViewController) {
        controller.popToViewController(LoginIndexViewController.self)
    }
}
