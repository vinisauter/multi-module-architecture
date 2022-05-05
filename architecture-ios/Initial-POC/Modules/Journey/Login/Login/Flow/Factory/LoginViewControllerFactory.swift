//
//  LoginViewControllersFactory.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core


public class LoginViewControllerFactory: BaseViewControllerFactory<LoginBusinessModel, LoginAnalyticsProtocol> {
    func makeLoginViewController(flow: LoginFlowProtocol, isIndex: Bool = false) -> LoginIndexViewController {
        let viewModel = LoginIndexViewModel(businessModel: businessModel, analytics: analytics as? LoginIndexAnalyticsProtocol, flowDelegate: flow as? LoginIndexFlowDelegate)
        viewModel.isIndex = isIndex
        return LoginIndexViewController(viewModel: viewModel)
    }
    
    func makeForgotPasswordViewController(flow: LoginFlowProtocol, isIndex: Bool = false) -> ForgotPasswordViewController {
        let viewModel = ForgotPasswordViewModel(businessModel: businessModel, analytics: analytics as? ForgotPasswordAnalyticsProtocol, flowDelegate: flow as? ForgotPasswordFlowDelegate)
        viewModel.isIndex = isIndex
        return ForgotPasswordViewController(viewModel: viewModel)
    }
}
