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
    var appNavigation: AppNavigation?
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?
    
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, value: Any?, appNavigation: AppNavigation, andCompletionHandler completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?) -> UIViewController {
        self.appNavigation = appNavigation
        self.completionHandler = completion
        
        let loginDependencies = LoginDependencies(url, self, DIContainer.shared, customAnalytics as? LoginAnalyticsProtocol, value)
        
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
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        isUserLoggedIn = journey == .home
        switch journey {
        case .home:
            appNavigation?.show(journeys: [.home], fromCurrentViewController: viewController, animated: true)
            appNavigation?.resolveDeeplinkIfNeeded()
            break
            
        case .welcome:
            appNavigation?.show(journeys: [.welcome], fromCurrentViewController: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?) {
        viewController.isModal ? viewController.dismiss(animated: true, completion: nil) : viewController.pop(animated: true)
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
}

extension DIContainer: LoginStructuralDependencies {}

extension LoginHandler: LoginFlowDelegate {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            if let completionHandler = completionHandler {
                completionHandler(.finish(.login), controller, value)
            } else {
                appNavigation?.perform(.finish(.login), in: controller, with: value)
            }
            break
            
        case .forgotPassword:
            if let completionHandler = completionHandler {
                completionHandler(.finish(.forgotPassword), controller, value)
            } else {
                appNavigation?.perform(.finish(.forgotPassword), in: controller, with: value)
            }
            break
            
        }
    }
    
    func onLoginSuccess(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            if let completionHandler = completionHandler {
                completionHandler(.finishCurrentAndGoTo(.home, currentJourney: .login), controller, value)
            } else {
                appNavigation?.perform(.finishCurrentAndGoTo(.home, currentJourney: .login), in: controller, with: value)
            }
        default: break
        }
    }
}
