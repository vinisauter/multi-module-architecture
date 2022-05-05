//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

class WelcomeViewController: UIViewController {
    weak var appNavigation: AppNavigation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        appNavigation?.perform(.finishCurrentAndGoTo(.login, currentJourney: .welcome), in: self, with: nil)
    }
}


class WelcomeHandler: ModuleHandler {
    var appNavigation: AppNavigation?
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?
        
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, value: Any?, appNavigation: AppNavigation, andCompletionHandler completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?) -> UIViewController {
        self.appNavigation = appNavigation
        self.completionHandler = completion
        
        let vc = UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
        vc.appNavigation = appNavigation
        return vc
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        appNavigation?.push(journey: .login, animated: true)
    }
    
    func canStart() -> Bool {
        return isAppLaunched
    }
    
    func getName() -> String {
        return Journey.welcome.rawValue
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?) {
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
    
    func getViewController(from url: URL) -> UIViewController? {
        return UIViewController()
    }
}
