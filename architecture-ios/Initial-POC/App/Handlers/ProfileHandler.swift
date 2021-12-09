//
//  ProfileHandler.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Profile

class ProfileHandler: ModuleHandler {
    
    private weak var baseFlowDelegate: BaseFlowDelegate?
    private weak var baseFlowDataSource: BaseFlowDataSource?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        self.baseFlowDataSource = baseFlowDataSource
        
        let profileDependencies = ProfileDependencies(url, self, self, StructuralDependencyProvider.shared, customModuleAnalytics as? ProfileAnalyticsProtocol, value)
        
        return ProfileLauncher.start(with: profileDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        return Journey.profile.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .home:
            AppNavigation.shared.show([.home], from: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
    }
}

extension StructuralDependencyProvider: ProfileStructuralDependencies {}

extension ProfileHandler: ProfileFlowDelegate {
    func goToHome(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            baseFlowDelegate?.perform(.finishCurrentAndGoTo(.home, currentJourney: .profile), in: controller, with: value)
            break
            
        default: break
        }
    }
}

extension ProfileHandler: ProfileFlowDataSource {
    func getLogin(from flow: Flow, with customAnalytics: Any?) -> UIViewController? {
        return baseFlowDataSource?.get(.login, from: .profile, with: self, customAnalytics: customAnalytics)
    }
    
    func getForgotPassword(from flow: Flow, with customAnalytics: Any?) -> UIViewController? {
        return baseFlowDataSource?.get(.forgotPassword, from: .profile, with: self, customAnalytics: customAnalytics)
    }
}

extension ProfileHandler: BaseFlowDelegate {
    func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?) {
        switch action {
        case .finish(let journey), .finishCurrentAndGoTo(_, let journey):
            handleDidFinish(journey, in: viewController, with: value)
            break
            
        default: break
        }
    }
    
    private func handleDidFinish(_ feature: Journey, in viewController: UIViewController, with value: Any?) {
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
