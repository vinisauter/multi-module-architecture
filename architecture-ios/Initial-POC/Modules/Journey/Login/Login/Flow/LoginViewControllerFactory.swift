//
//  LoginViewControllersFactory.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core


public class LoginViewControllerFactory: BaseViewControllerFactory<LoginUseCaseProtocol, LoginAnalyticsProtocol> {
    weak var flow: LoginFlowProtocol?
    
    func makeLoginViewController() -> LoginIndexViewController {
        return LoginIndexViewController(viewModel: LoginIndexViewModel(useCase: businessModel, analytics: analytics), flowDelegate: flow as? LoginIndexFlowDelegate)
    }
}
