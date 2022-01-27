//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

class WelcomeViewController: UIViewController {
    public var appNavigation: AppNavigation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let vc = appNavigation?.start(.login, baseFlowDelegate: appNavigation!, baseFlowDataSource: appNavigation!)
        show(vc!, sender: nil)
    }
}


class WelcomeHandler: ModuleHandler {
    private weak var appNavigation: AppNavigation?
    
    init(appNavigation: AppNavigation) {
        self.appNavigation = appNavigation
    }
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        let vc = UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
        vc.appNavigation = appNavigation!
        
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
}
