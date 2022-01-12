//
//  ViewController.swift
//  CoreDemo
//
//  Created by Avanade on 11/01/22.
//

import UIKit
import Core

class ViewController: BaseViewController<ViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
    }
}

class ViewModel: BaseViewModel<Any, Any, Any> {
    
}

