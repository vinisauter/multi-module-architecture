//
//  AppNavigation+HomeFlow.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import UIKit
import Core

extension AppNavigation {
    func handleHomeFlowGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .profile:
            push(startProfile(baseFlowDelegate: self, baseFlowDataSource: self))
            break
            
        case .login:
            setRootViewController(startLogin(baseFlowDelegate: self))
            break
            
        default: break
        }
    }
    
    func handleGetHomeFlow(from journey: BaseFlowDelegate) -> UIViewController {
        return startHome(baseFlowDelegate: journey)
    }
}
