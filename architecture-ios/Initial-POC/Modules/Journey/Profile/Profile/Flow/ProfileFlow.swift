//
//  ProfileFlow.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

protocol ProfileFlowProtocol: AnyObject {
    var factory: ProfileViewControllerFactory { get }
    var deeplink: Deeplink<ProfileDeeplink>? { get set }
    var delegate: ProfileFlowDelegate? { get set }
    var dataSource: ProfileFlowDataSource? { get set }
    func start() -> UIViewController
}

public protocol ProfileFlowDelegate: AnyObject {
    func goToHome(from flow: Flow, in controller: UIViewController, with value: Any?)
}

public protocol ProfileFlowDataSource: AnyObject {
    func getLogin(from flow: Flow, with customAnalytics: Any?) -> UIViewController?
    func getForgotPassword(from flow: Flow, with customAnalytics: Any?) -> UIViewController?
}

class ProfileFlow: ProfileFlowProtocol, Deeplinkable {
    var factory: ProfileViewControllerFactory
    
    var deeplink: Deeplink<ProfileDeeplink>?
    
    weak var delegate: ProfileFlowDelegate?
    
    weak var dataSource: ProfileFlowDataSource?
    
    init(factory: ProfileViewControllerFactory, deeplink: Deeplink<ProfileDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeProfileHomeViewController(isIndex: true)
    }
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink, let screen = deeplink.value else { return }
        self.deeplink = nil
        
        switch screen {
        case .index: break
        case .forgotPassword:
            controller.show(getForgotPassword() ?? UIViewController(), sender: nil)
            break
        }
    }
    
    private func getForgotPassword() -> UIViewController? {
        guard let forgotPassswordVC = dataSource?.getForgotPassword(from: .main, with: factory.defaultAnalytics) else { return nil }
        return forgotPassswordVC
    }
}

// MARK: - LoginViewControllerFlowDelegate

extension ProfileFlow: ProfileHomeFlowDelegate {
    func goToHome(in controller: ProfileHomeViewController) {
        delegate?.goToHome(from: .main, in: controller, with: nil)
    }
    
    func callLogin(in controller: ProfileHomeViewController) {
        guard let loginVC = dataSource?.getLogin(from: .main, with: factory.defaultAnalytics) else { return }
        
        
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        controller.present(navigationController, animated: true)
    }
    
    func goToForgotPassword(in controller: ProfileHomeViewController) {
        guard let forgotPassswordVC = getForgotPassword() else { return }
        
        controller.show(forgotPassswordVC, sender: nil)
    }
}
