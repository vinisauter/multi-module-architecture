//
//  ViewController.swift
//  Initial-POC
//
//  Created by Felippe Matos on 08/11/21.
//

import UIKit

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
        show(AppNavigation.shared.startLogin(baseFlowDelegate: AppNavigation.shared), sender: nil)
    }
    
}

