//
//  ForgotPasswordViewModel.swift
//  Login
//
//  Created by Felippe Matos on 16/11/21.
//

import Foundation

protocol ForgotPasswordViewModelProtocol {
    func recoveryPassword() -> String
}

class ForgotPasswordViewModel:ForgotPasswordViewModelProtocol {
    let businessModel: LoginBusinessProtocol
    
    public init(businessModel: LoginBusinessProtocol) {
        self.businessModel = businessModel
    }
    
    func recoveryPassword() -> String {
        return "Password recuperado"
    }
}
