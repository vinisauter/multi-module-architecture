//
//  ForgotPasswordViewModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 12/11/21.
//

import Core

public protocol ForgotPasswordViewModelProtocol: ForgotPasswordBusinessModelProtocol, ForgotPasswordFlowDelegate {}

class ForgotPasswordViewModel: BaseViewModel<ForgotPasswordBusinessModelProtocol, ForgotPasswordAnalyticsProtocol, ForgotPasswordFlowDelegate>, ForgotPasswordViewModelProtocol {
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        analytics?.onChangePasswordClick()
        businessModel?.changePassword(with: newPassword, completion: completion)
    }
    
    func onChangePasswordSuccess(in controller: ForgotPasswordViewController) {
        flowDelegate?.onChangePasswordSuccess(in: controller)
    }
}
