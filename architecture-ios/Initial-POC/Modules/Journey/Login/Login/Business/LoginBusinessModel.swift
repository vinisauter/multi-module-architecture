//
//  LoginBusinessModel.swift
//  Login
//
//  Created by Felippe Matos on 11/11/21.
//

import Foundation

enum ResultFromLogin {
    case success
    case error
}

protocol LoginBusinessProtocol {
    func login(cpf: String, password: String) -> ResultFromLogin
}

class LoginBusinessModel: LoginBusinessProtocol {
    let repository: LoginApiProtocol = LoginApi()
    
    func login(cpf: String, password: String) -> ResultFromLogin {
        var validatedUser = false
        var validatedPassword = false
        
        for user in repository.listOfUsers() {
            if user.cpf == cpf {
                validatedUser = true
            }
            
            if user.password == password {
                validatedPassword = true
            }
            
            if validatedUser && validatedPassword {
                return .success
            }
        }
        return .error
    }
    
}
