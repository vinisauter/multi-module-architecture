//
//  WelcomeHandler.swift
//  App
//
//  Created by ACT on 07/02/22.
//

import Foundation
import Core
import UIKit

public class WelcomeHandler: ModuleHandler {
    
    public init(){}
    
    public func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        return UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
    }
    
    public func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        
    }
    
    public func canStart() -> Bool {
        return isAppLaunched
    }
    
    public func getName() -> String {
        return Journey.welcome.rawValue
    }
    
    public func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
    }
}
