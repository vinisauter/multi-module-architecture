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
    var baseFlowDelegate: BaseFlowDelegate? { get set }
    var baseFlowDataSource: BaseFlowDataSource? { get set }
    func start() -> UIViewController
}

class ProfileFlow: ProfileFlowProtocol, Deeplinkable {
    var factory: ProfileViewControllerFactory
    
    var deeplink: Deeplink<ProfileDeeplink>?
    
    weak var baseFlowDelegate: BaseFlowDelegate?
    
    weak var baseFlowDataSource: BaseFlowDataSource?
    
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
        guard let forgotPassswordVC = baseFlowDataSource?.get(.forgotPassword, from: .profile, with: self, customAnalytics: factory.defaultAnalytics) else { return nil }
        return forgotPassswordVC
    }
}

// MARK: - LoginViewControllerFlowDelegate

extension ProfileFlow: ProfileHomeFlowDelegate {
    func goToHome(in controller: ProfileHomeViewController) {
        baseFlowDelegate?.perform(.finishCurrentAndGoTo(.home, currentJourney: .profile), in: controller, with: nil)
    }
    
    func callLogin(in controller: ProfileHomeViewController) {
        guard let loginVC = baseFlowDataSource?.get(.login, from: .profile, with: self, customAnalytics: factory.defaultAnalytics) else { return }
        
        
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        controller.present(navigationController, animated: true)
    }
    
    func goToForgotPassword(in controller: ProfileHomeViewController) {
        guard let forgotPassswordVC = getForgotPassword() else { return }
        
        controller.show(forgotPassswordVC, sender: nil)
    }
}

// MARK: - BaseFlowDelegate

extension ProfileFlow: BaseFlowDelegate {
    func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?) {
        switch action {
        case .finish(let journey), .finishCurrentAndGoTo(_, let journey):
            handleDidFinish(journey, in: viewController, with: value)
            break
            
        default: break
        }
    }
    
    func handleDidFinish(_ feature: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch feature {
        case .login:
            viewController.dismiss(animated: true)
            break
            
        case .forgotPassword:
            viewController.pop(animated: true)
            
        default: break
        }
    }
}
