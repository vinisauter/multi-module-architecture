//
//  LoginViewModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol LoginIndexViewModelProtocol: LoginIndexBusinessModelProtocol, LoginIndexFlowDelegate {}

class LoginIndexViewModel: BaseViewModel<LoginIndexBusinessModelProtocol, LoginIndexAnalyticsProtocol, LoginIndexFlowDelegate>, LoginIndexViewModelProtocol {
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        analytics?.onLoginClick()
        businessModel?.login(with: username, and: password, completion: completion)
    }
    
    func onForgotPasswordClick(in controller: LoginIndexViewController) {
        analytics?.onForgotPasswordClick()
        flowDelegate?.onForgotPasswordClick(in: controller)
    }
    
    func onLoginSuccess(in controller: LoginIndexViewController) {
        flowDelegate?.onLoginSuccess(in: controller)
    }
    
    func onCloseClick(in controller: LoginIndexViewController) {
        flowDelegate?.onCloseClick(in: controller)
    }
    
    func onBackClick(in controller: LoginIndexViewController) {
        flowDelegate?.onBackClick(in: controller)
    }
}
