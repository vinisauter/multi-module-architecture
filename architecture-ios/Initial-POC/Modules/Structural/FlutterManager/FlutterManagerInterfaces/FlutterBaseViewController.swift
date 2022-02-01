//
//  FlutterBaseViewController.swift
//  FlutterManagerInterfaces
//
//  Created by Ailton Vieira Pinto Filho on 01/02/22.
//

import UIKit
import Flutter

class FlutterBaseViewController: UIViewController {
    let bundle: Bundle
    let flutterManager: FlutterManagerProtocol
    
    var spinner: UIActivityIndicatorView!
    
    init(from bundle: Bundle, flutterManager: FlutterManagerProtocol) {
        self.bundle = bundle
        self.flutterManager = flutterManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        spinner = UIActivityIndicatorView(style: .large)
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        self.flutterManager.attach(from: self.bundle, in: self.view, parentController: self) { [spinner] _ in
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
        }
    }
}
