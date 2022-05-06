//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit
import Core

class WelcomeViewController: UIViewController {
    weak var navigationDelegate: ModuleHandlerNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        navigationDelegate?.perform(.finishCurrentAndGoTo(.login, currentJourney: .welcome), in: self, with: nil)
    }
}


class WelcomeHandler: ModuleHandlerProtocol {
    var navigationDelegate: ModuleHandlerNavigationDelegate?
    var navigationDataSource: AppNavigationDataSource?
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?
        
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, andValue value: Any?) -> UIViewController {
        let vc = UIViewController.instantiateViewController(ofType: WelcomeViewController.self)!
        vc.navigationDelegate = navigationDelegate
        return vc
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigationProtocol) {
        appNavigation.push(journey: .login, fromCurrentViewController: viewController, withValue: nil, animated: true)
    }
    
    func canStart() -> Bool {
        return isAppLaunched
    }
    
    func getName() -> String {
        return Journey.welcome.rawValue
    }
    
    func handleFinish(in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigationProtocol) {
        debugPrint("++++++++ \(#fileID) - \(#function)")
    }
    
    func getViewController(from url: URL) -> UIViewController? {
        return UIViewController()
    }
}
