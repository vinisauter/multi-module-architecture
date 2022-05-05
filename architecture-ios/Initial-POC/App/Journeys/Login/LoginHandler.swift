//
//  LoginHandler.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Login

class LoginHandler: ModuleHandler {
    var baseFlowDataSource: BaseFlowDataSource?
    var baseFlowDelegate: BaseFlowDelegate?
    
    func launch(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        let loginDependencies = LoginDependencies(url, self, DIContainer.shared, customModuleAnalytics as? LoginAnalyticsProtocol, value)
        
        var startViewController: UIViewController = LoginLauncher.start(with: loginDependencies)
        
        if let subJourney = subJourney {
            switch subJourney {
            case .forgotPassword:
                startViewController = LoginLauncher.startForgotPassword(with: loginDependencies)
            default: break
            }
        }
        
        return startViewController
    }
    
    func canStart() -> Bool {
        return isAppLaunched
    }
    
    func getName() -> String {
        return Journey.login.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigation) {
        isUserLoggedIn = journey == .home
        switch journey {
        case .home:
            appNavigation.show(journeys: [.home], fromCurrentViewController: viewController, animated: true)
            appNavigation.resolveDeeplinkIfNeeded()
            break
            
        case .welcome:
            appNavigation.show(journeys: [.welcome], fromCurrentViewController: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigation) {
        viewController.isModal ? viewController.dismiss(animated: true, completion: nil) : viewController.pop(animated: true)
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
}

extension DIContainer: LoginStructuralDependencies {}

extension LoginHandler: LoginFlowDelegate {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            baseFlowDelegate?.perform(.finish(.login), in: controller, with: value)
            break
            
        case .forgotPassword:
            baseFlowDelegate?.perform(.finish(.forgotPassword), in: controller, with: value)
            break
        }
    }
    
    func onLoginSuccess(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            baseFlowDelegate?.perform(.finishCurrentAndGoTo(.home, currentJourney: .login), in: controller, with: nil)
        default: break
        }
    }
}
