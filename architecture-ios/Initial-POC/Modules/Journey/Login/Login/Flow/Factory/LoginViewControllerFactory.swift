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
        let viewModel = LoginIndexViewModel(useCase: businessModel as? LoginIndexUseCaseProtocol, analytics: customAnalytics as? LoginIndexAnalyticsProtocol ?? defaultAnalytics as? LoginIndexAnalyticsProtocol, flowDelegate: flow as? LoginIndexFlowDelegate)
        viewModel.isIndex = isIndex
        return LoginIndexViewController(viewModel: viewModel)
    }
    
    func makeForgotPasswordViewController(isIndex: Bool = false) -> ForgotPasswordViewController {
        let viewModel = ForgotPasswordViewModel(useCase: businessModel as? ForgotPasswordUseCaseProtocol, analytics: customAnalytics as? ForgotPasswordAnalyticsProtocol ?? defaultAnalytics as? ForgotPasswordAnalyticsProtocol, flowDelegate: flow as? ForgotPasswordFlowDelegate)
        viewModel.isIndex = isIndex
        return ForgotPasswordViewController(viewModel: viewModel)
    }
}
