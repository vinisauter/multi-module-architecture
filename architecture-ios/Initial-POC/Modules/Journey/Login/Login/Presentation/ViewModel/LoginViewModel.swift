//
//  LoginViewModel.swift
//  Login
//
//  Created by Felippe Matos on 11/11/21.
//

import Foundation

protocol LoginViewModelProtocol {
    var businessModel: LoginBusinessProtocol { get set }
    func login(cpf: String, password: String) -> Bool
}

class LoginViewModel: LoginViewModelProtocol {
    var businessModel: LoginBusinessProtocol
    
    public init(businessModel: LoginBusinessProtocol) {
        self.businessModel = businessModel
    }
    
    func login(cpf: String, password: String) -> Bool {
        let loginValidated = self.businessModel.login(cpf: cpf, password: password)
        
        switch loginValidated {
        case .success:
            return true
        default:
            return false
        }
    }
}
