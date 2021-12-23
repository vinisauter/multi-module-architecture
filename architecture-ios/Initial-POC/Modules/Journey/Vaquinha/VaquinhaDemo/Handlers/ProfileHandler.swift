//
//  ProfileHandler.swift
//  Vaquinha
//
//  Created by Avanade on 23/12/21.
//

import Profile
import UIKit
import Core


class ProfileHandler: ModuleHandler {
    private weak var baseFlowDelegate: BaseFlowDelegate?
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let profileDependencies = ProfileDependencies(url, self, nil, StructuralDependencyProvider.shared, customModuleAnalytics as? ProfileAnalyticsProtocol, value)
        
        return ProfileLauncher.start(with: profileDependencies)
    }
    
    func canStart() -> Bool {
        isUserLoggedIn
    }
    
    func getName() -> String {
        Journey.profile.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .vaquinha:
            AppNavigation.shared.show([.vaquinha], animated: false)
            isUserLoggedIn = false
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
    func goToHome(from flow: Flow, in controller: UIViewController, with value: Any?) {}
}
