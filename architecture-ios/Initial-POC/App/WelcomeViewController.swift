//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

class WelcomeViewController: UIViewController {
    var appNavigation: AppNavigationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let vc = appNavigation!.start(journey: .login, fromCurrentJourney: nil, withSubJourney: .welcome, url: nil, baseFlowDelegate: appNavigation as! BaseFlowDelegate, baseFlowDataSource: appNavigation as! BaseFlowDataSource, customModuleAnalytics: nil, andValue: nil)
        show(vc, sender: nil)
    }
}


class WelcomeHandler: ModuleHandler {
    var baseFlowDelegate: BaseFlowDelegate?
    
    var baseFlowDataSource: BaseFlowDataSource?
    
    var appNavigation: AppNavigationProtocol
    
    init(appNavigation: AppNavigationProtocol) {
        self.appNavigation = appNavigation
    }
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        let vc = UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
        vc.appNavigation = appNavigation
        return vc
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        
    }
    
    func canStart() -> Bool {
        return isAppLaunched
    }
    
    func getName() -> String {
        return Journey.welcome.rawValue
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?) {}
    
    func handleDeeplink(_ url: URL) -> Bool {
        debugPrint("Chamou o \(#fileID) - \(#function)")
        return false
    }
}
