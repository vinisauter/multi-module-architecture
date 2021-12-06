//
//  LoginViewControllersFactory.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core


// parameter (loginUserCase Protocol) should not be the business Model class (LoginBunisses Model)
// parameters useCase at class LoginIndexViewModel in viewmodel is confusing with bunissesModel

public class LoginViewControllerFactory: BaseViewControllerFactory<LoginUseCaseProtocol, LoginAnalyticsProtocol> {
    weak var flow: LoginFlowProtocol?
    
    func makeLoginViewController(isIndex: Bool = false) -> LoginIndexViewController {
        let viewModel = LoginIndexViewModel(useCase: businessModel as? LoginIndexUseCaseProtocol, analytics: customAnalytics as? LoginIndexAnalyticsProtocol ?? defaultAnalytics as? LoginIndexAnalyticsProtocol)
        viewModel.isIndex = isIndex
        return LoginIndexViewController(viewModel: viewModel, flowDelegate: flow as? LoginIndexFlowDelegate)
    }
    
    func makeForgotPasswordViewController(isIndex: Bool = false) -> ForgotPasswordViewController {
        let viewModel = ForgotPasswordViewModel(useCase: businessModel as? ForgotPasswordUseCaseProtocol, analytics: customAnalytics as? ForgotPasswordAnalyticsProtocol ?? defaultAnalytics as? ForgotPasswordAnalyticsProtocol)
        viewModel.isIndex = isIndex
        return ForgotPasswordViewController(viewModel: viewModel, flowDelegate: flow as? ForgotPasswordFlowDelegate)
    }
}
