//
//  LoginHandler.swift
//  TaskDemo
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import UIKit
import Core
import Login

var isUserLoggedIn: Bool = false
var isAppLaunched: Bool = false

extension Journey {
    static let login: Journey = Journey(rawValue: "login")
    static let forgotPassword: Journey = Journey(rawValue: "forgotPassword")
    static let task: Journey = Journey(rawValue: "task")
}

class LoginHandler: ModuleHandler {
    private weak var baseFlowDelegate: BaseFlowDelegate?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        let loginDependencies = LoginDependencies(url, self, StructuralDependencyProvider.shared, customModuleAnalytics as? LoginAnalyticsProtocol, value)
        
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
        return isAppLaunched && !isUserLoggedIn
    }
    
    func getName() -> String {
        return Journey.login.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        isUserLoggedIn = journey == .task
        switch journey {
        case .task:
            AppNavigation.shared.push(.task, from: viewController, animated: true)
            AppNavigation.shared.resolveDeeplinkIfNeeded()
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        switch journey {
        default: return AppNavigation.shared.start(.login, from: journey, baseFlowDelegate: baseFlowDelegate)
        }
    }
}

extension StructuralDependencyProvider: LoginStructuralDependencies {}

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
    
    func goToHome(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            baseFlowDelegate?.perform(.goTo(.task, currentJourney: .login), in: controller, with: nil)
        default: break
        }
    }
    
    func goToWelcome(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        default: break
        }
    }
}
