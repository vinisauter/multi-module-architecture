//
//  LoginViewModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol LoginIndexUseCaseProtocol {
    func login(with username: String, and password: String, completion: @escaping (_ success: Bool) -> Void)
}

public protocol LoginIndexAnalyticsProtocol {
    func onLoginClick()
}

public protocol LoginIndexViewModelProtocol: LoginIndexUseCaseProtocol {}

class LoginIndexViewModel: BaseViewModel<LoginIndexUseCaseProtocol, LoginIndexAnalyticsProtocol, LoginDeeplink>, LoginIndexViewModelProtocol {
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        analytics?.onLoginClick()
        useCase?.login(with: username, and: password, completion: completion)
    }
}
