//
//  ForgotPasswordViewModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 12/11/21.
//

import Core

public protocol ForgotPasswordUseCaseProtocol {
    func changePassword(with newPassword: String, completion: @escaping (_ success: Bool) -> Void)
}

public protocol ForgotPasswordAnalyticsProtocol {
    func onChangePasswordClick()
}

public protocol ForgotPasswordViewModelProtocol: ForgotPasswordUseCaseProtocol {}

class ForgotPasswordViewModel: BaseViewModel<ForgotPasswordUseCaseProtocol, ForgotPasswordAnalyticsProtocol, LoginDeeplink>, ForgotPasswordViewModelProtocol {
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        analytics?.onChangePasswordClick()
        useCase?.changePassword(with: newPassword, completion: completion)
    }
}
