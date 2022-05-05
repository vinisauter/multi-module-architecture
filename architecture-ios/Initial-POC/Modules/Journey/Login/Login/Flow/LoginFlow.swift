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
    var delegate: LoginFlowDelegate? { get set }
    var deeplink: Deeplink<LoginDeeplink>? { get set }
    func start() -> UIViewController
    func getViewController(fromDeeplink deeplink: Deeplink<LoginDeeplink>) -> UIViewController?
}

public protocol LoginFlowDelegate: AnyObject {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?)
    func onLoginSuccess(from flow: Flow, in controller: UIViewController, with value: Any?)
}

class LoginFlow: LoginFlowProtocol, Deeplinkable {
    var factory: LoginViewControllerFactory
    
    var deeplink: Deeplink<LoginDeeplink>?
    
    weak var delegate: LoginFlowDelegate?
    
    init(factory: LoginViewControllerFactory, deeplink: Deeplink<LoginDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeLoginViewController(flow: self, isIndex: true)
    }
    
    func getViewController(fromDeeplink deeplink: Deeplink<LoginDeeplink>) -> UIViewController? {
        guard let screen = deeplink.value, let url = deeplink.url else { return nil }
        
        switch screen {
        case .forgotPassword:
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let userName = urlComponents?.queryItems?.first{ $0.name == "userName" }
            debugPrint(userName ?? "")
            return factory.makeForgotPasswordViewController(flow: self)
                                                            
        default: return nil
        }
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
            controller.show(factory.makeForgotPasswordViewController(flow: self), sender: nil)
            break
        }
    }
}

// MARK: - LoginIndexFlowDelegate

extension LoginFlow: LoginIndexFlowDelegate {
    func onBackClick(in controller: LoginIndexViewController) {
        delegate?.didFinish(.main, in: controller, with: nil)
    }
    
    func onCloseClick(in controller: LoginIndexViewController) {
        delegate?.didFinish(.main, in: controller, with: nil)
    }
    
    func onForgotPasswordClick(in controller: LoginIndexViewController) {
        controller.show(factory.makeForgotPasswordViewController(flow: self), sender: nil)
    }
    
    func onLoginSuccess(in controller: LoginIndexViewController) {
        delegate?.onLoginSuccess(from: .main, in: controller, with: nil)
    }
}

// MARK: - ForgotPasswordFlowDelegate

extension LoginFlow: ForgotPasswordFlowDelegate {
    func onChangePasswordSuccess(in controller: ForgotPasswordViewController) {
        controller.popToViewController(LoginIndexViewController.self)
    }
}
