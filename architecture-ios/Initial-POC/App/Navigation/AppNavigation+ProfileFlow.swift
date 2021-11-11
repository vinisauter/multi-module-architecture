//
//  AppNavigation+ProfileFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core
import Home

extension AppNavigation {
    func handleProfileFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .home:
            navigationController.popToViewControllerWithType(HomeIndexViewController.self)
            break
            
        default: break
        }
    }
    
    func handleGetProfileFlow(from journey: BaseFlowDelegate) -> UIViewController {
        return startProfile(baseFlowDelegate: journey, baseFlowDataSource: self)
    }
}
