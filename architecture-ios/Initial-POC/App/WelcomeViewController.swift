//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        show(AppNavigation.shared.start(.login), sender: nil)
    }
}


class WelcomeStarter: ModuleStarter {
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: JourneyModuleAnalyticsProtocol?, _ subJourney: JourneyModule?) -> UIViewController {
        return UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
    }
    
    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?) {
        
    }
    
    func canStart() -> Bool {
        return isAppLaunched
    }
    
    func getPath() -> String {
        return "welcome"
    }
    
    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController {
        UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
    }
}
