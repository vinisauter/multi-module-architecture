//
//  LoginViewModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol LoginIndexViewModelProtocol: LoginIndexBusinessModelProtocol, LoginIndexFlowDelegate {}

public class LoginIndexViewModel: BaseViewModel<LoginIndexBusinessModelProtocol, LoginIndexAnalyticsProtocol, LoginIndexFlowDelegate>, LoginIndexViewModelProtocol {
    
    public func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        analytics?.onLoginClick()
        businessModel?.login(with: username, and: password, completion: completion)
    }
    
    public func onForgotPasswordClick(in controller: LoginIndexViewController) {
        analytics?.onForgotPasswordClick()
        flowDelegate?.onForgotPasswordClick(in: controller)
    }
    
    public func onLoginSuccess(in controller: LoginIndexViewController) {
        flowDelegate?.onLoginSuccess(in: controller)
    }
    
    public func onCloseClick(in controller: LoginIndexViewController) {
        flowDelegate?.onCloseClick(in: controller)
    }
    
    public func onBackClick(in controller: LoginIndexViewController) {
        flowDelegate?.onBackClick(in: controller)
    }
}
