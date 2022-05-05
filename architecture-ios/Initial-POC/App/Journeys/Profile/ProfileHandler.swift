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
    var appNavigation: AppNavigation?
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?
        
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, value: Any?, appNavigation: AppNavigation, andCompletionHandler completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?) -> UIViewController {
        self.appNavigation = appNavigation
        self.completionHandler = completion
        let profileDependencies = ProfileDependencies(url, self, self, DIContainer.shared, customAnalytics as? ProfileAnalyticsProtocol, value)
        
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
            appNavigation?.show(journeys: [.home], fromCurrentViewController: viewController, animated: true)
            break
            
        default: break
        }
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?) {
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
}

extension DIContainer: ProfileStructuralDependencies {}

extension ProfileHandler: ProfileFlowDelegate {
    func goToHome(from flow: Flow, in controller: UIViewController, with value: Any?) {
        switch flow {
        case .main:
            if let completionHandler = completionHandler {
                completionHandler(.finishCurrentAndGoTo(.home, currentJourney: .profile), controller, value)
            } else {
                appNavigation?.perform(.finishCurrentAndGoTo(.home, currentJourney: .profile), in: controller, with: value)
            }
            break
            
        default: break
        }
    }
}

extension ProfileHandler: ProfileFlowDataSource {
    func getLogin(from flow: Flow, with customAnalytics: Any?) -> UIViewController? {
        return appNavigation?.get(.login, customAnalytics: LoginAnalyticsProfileAdapter(profileAnalytics: customAnalytics), completion: { [weak self] action, viewController, value in
            switch action {
            case .finish(let journey), .finishCurrentAndGoTo(_, let journey):
                self?.handleDidFinish(journey, in: viewController, with: value)
                break

            default: break
            }
        })
    }
    
    func getForgotPassword(from flow: Flow, with customAnalytics: Any?) -> UIViewController? {
        return appNavigation?.get(.forgotPassword, customAnalytics: LoginAnalyticsProfileAdapter(profileAnalytics: customAnalytics), completion: { [weak self] action, viewController, value in
            switch action {
            case .finish(let journey), .finishCurrentAndGoTo(_, let journey):
                self?.handleDidFinish(journey, in: viewController, with: value)
                break

            default: break
            }
        })
    }
    
    fileprivate func handleDidFinish(_ journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .login:
            viewController.dismiss(animated: true)
            break

        case .forgotPassword:
            viewController.pop(animated: true)

        default: break
        }
    }
}
