//
//  ForgotPasswordFlow.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 19/11/21.
//

import UIKit
import Core

class ForgotPasswordFlow: LoginFlowProtocol, Deeplinkable {
    var factory: LoginViewControllerFactory
    
    var deeplink: Deeplink<LoginDeeplink>?
    
    weak var delegate: LoginFlowDelegate?
    
    init(factory: LoginViewControllerFactory, deeplink: Deeplink<LoginDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeForgotPasswordViewController(isIndex: true)
    }
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink, let screen = deeplink.value, let _ = deeplink.url else { return }
        self.deeplink = nil
        
        switch screen {
        case .index: break
        case .forgotPassword: break
        }
    }
}

extension ForgotPasswordFlow: ForgotPasswordFlowDelegate {
    func onChangePasswordSuccess(in controller: ForgotPasswordViewController) {
        delegate?.didFinish(.forgotPassword, in: controller, with: nil)
    }
}
