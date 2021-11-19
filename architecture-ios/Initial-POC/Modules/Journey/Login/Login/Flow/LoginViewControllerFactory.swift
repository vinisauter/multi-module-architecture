//
//  LoginViewControllersFactory.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core


public class LoginViewControllerFactory: BaseViewControllerFactory<LoginUseCaseProtocol, LoginAnalyticsProtocol> {
    weak var flow: LoginFlowProtocol?
    
    func makeLoginViewController(isIndex: Bool = false) -> LoginIndexViewController {
        let viewModel = LoginIndexViewModel(useCase: businessModel as? LoginIndexUseCaseProtocol, analytics: analytics as? LoginIndexAnalyticsProtocol)
        viewModel.isIndex = isIndex
        return LoginIndexViewController(viewModel: viewModel, flowDelegate: flow as? LoginIndexFlowDelegate)
    }
    
    func makeForgotPasswordViewController() -> ForgotPasswordViewController {
        let viewModel = ForgotPasswordViewModel(useCase: businessModel as? ForgotPasswordUseCaseProtocol, analytics: analytics as? ForgotPasswordAnalyticsProtocol)
        return ForgotPasswordViewController(viewModel: viewModel, flowDelegate: flow as? ForgotPasswordFlowDelegate)
    }
}
