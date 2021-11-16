//
//  AppNavigation+LoginFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Login

extension AppNavigation {
    func startLogin(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil) -> UIViewController {
        return LoginLauncher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics)
    }
    
    func handleLoginFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .home:
            setRootViewController(startHome(baseFlowDelegate: self), animated: true)
            break
            
        default: break
        }
    }
    
    func handleGetLoginFlow(from journey: BaseFlowDelegate) -> UIViewController {
        return startLogin(baseFlowDelegate: journey)
    }
}
