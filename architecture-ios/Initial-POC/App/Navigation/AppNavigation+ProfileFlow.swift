//
//  AppNavigation+ProfileFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Home
import Profile

extension AppNavigation {
    func startProfile(from deeplink: URL? = nil, baseFlowDelegate: BaseFlowDelegate? = nil, baseFlowDataSource: BaseFlowDataSource? = nil) -> UIViewController {
        return ProfileLauncher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics)
    }
    
    func handleProfileFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .home:
            guard (popToViewControllerWithType(HomeIndexViewController.self) != nil) else {
                setRootViewController(startHome(baseFlowDelegate: self), animated: true)
                return
            }
            break
            
        default: break
        }
    }
    
    func handleGetProfileFlow(from journey: BaseFlowDelegate) -> UIViewController {
        return startProfile(baseFlowDelegate: journey, baseFlowDataSource: self)
    }
}
