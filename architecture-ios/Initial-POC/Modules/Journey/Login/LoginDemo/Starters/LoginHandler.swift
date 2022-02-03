//
//  LoginStarter.swift
//  LoginDemo
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

//import UIKit
//import Core
//import Login
//
//class LoginStarter: ModuleHandler {
//
//    init() {}
//
//    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: JourneyModule?, _ value: Any?) -> UIViewController {
//        let loginDependencies = LoginDependencies(url, baseFlowDelegate, StructuralDependencyProvider.shared, customModuleAnalytics as? LoginAnalyticsProtocol, value)
//
//        var startViewController: UIViewController = LoginLauncher.start(with: loginDependencies)
//
//        if let subJourney = subJourney {
//            switch subJourney {
//            case .forgotPassword:
//                startViewController = LoginLauncher.startForgotPassword(with: loginDependencies)
//            default: break
//            }
//        }
//
//        return startViewController
//    }
//
//    func canStart() -> Bool {
//        return isAppLaunched && !isUserLoggedIn
//    }
//
//    func getName() -> String {
//        return "login"
//    }
//
//    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
//        isUserLoggedIn = journey == .home
//        AppNavigation.shared.show([.home], from: viewController, animated: true)
//        AppNavigation.shared.resolveDeeplinkIfNeeded()
//
//    }
//
//    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
//        switch journey {
//        default: return AppNavigation.shared.start(.login, from: journey, baseFlowDelegate: baseFlowDelegate)
//        }
//    }
//}
//
//extension StructuralDependencyProvider: LoginStructuralDependencies {}


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
        isUserLoggedIn = journey == .home
        switch journey {
        case .home:
            AppNavigation.shared.show([.home], from: viewController, animated: true)
            AppNavigation.shared.resolveDeeplinkIfNeeded()
            break
            
        case .welcome:
            AppNavigation.shared.show([.welcome], from: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        switch journey {
//        case .profile: return AppNavigation.shared.start(.login, to: subJourney, from: journey, baseFlowDelegate: baseFlowDelegate, customModuleAnalytics: analytics != nil ? LoginAnalyticsProfileAdapter(profileAnalytics: analytics) : nil)
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
            baseFlowDelegate?.perform(.finishCurrentAndGoTo(.home, currentJourney: .login), in: controller, with: nil)
        default: break
        }
    }
    
    func goToWelcome(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            baseFlowDelegate?.perform(.finishCurrentAndGoTo(.welcome, currentJourney: .login), in: controller, with: nil)
        default: break
        }
    }
}
