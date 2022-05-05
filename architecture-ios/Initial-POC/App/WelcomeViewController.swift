//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

class WelcomeViewController: UIViewController {
    weak var baseFlowDelegate: BaseFlowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        baseFlowDelegate?.perform(.finishCurrentAndGoTo(.login, currentJourney: .welcome), in: self, with: nil)
    }
}


class WelcomeHandler: ModuleHandler {
    var baseFlowDelegate: BaseFlowDelegate?
    var baseFlowDataSource: BaseFlowDataSource?
        
    func launch(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        let vc = UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
        vc.baseFlowDelegate = baseFlowDelegate
        return vc
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigation) {
        appNavigation.push(journey: .login, animated: true)
    }
    
    func canStart() -> Bool {
        return isAppLaunched
    }
    
    func getName() -> String {
        return Journey.welcome.rawValue
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigation) {
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
    
    func getViewController(from url: URL) -> UIViewController? {
        return UIViewController()
    }
}
