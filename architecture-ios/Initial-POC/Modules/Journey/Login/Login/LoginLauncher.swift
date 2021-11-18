//
//  LoginLauncher.swift
//  Login
//
//  Created by Felippe Matos on 10/11/21.
//

import UIKit

public protocol LoginNavigationDelegate: AnyObject {
    func goToJourneyByLogin()
}

public protocol LoginNavigationProtocol: AnyObject {
    func start(delegate: LoginNavigationDelegate?) -> UIViewController
    func finish(delegate: LoginNavigationDelegate?)
}

open class LoginLauncher: LoginNavigationProtocol {
    static let shared: LoginLauncher = LoginLauncher()
    
    var businessModel: LoginBusinessProtocol = LoginBusinessModel()
    
    public init() {}
    
    public func start(delegate: LoginNavigationDelegate?) -> UIViewController {
        let viewModel = LoginViewModel(businessModel: LoginLauncher.shared.businessModel)
        return LoginViewController(viewModel: viewModel, delegate: delegate)
    }
    
    public func finish(delegate: LoginNavigationDelegate?) {
        delegate?.goToJourneyByLogin()
    }
}

