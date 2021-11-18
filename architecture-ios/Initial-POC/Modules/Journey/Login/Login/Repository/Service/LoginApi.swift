//
//  LoginApi.swift
//  Login
//
//  Created by Felippe Matos on 11/11/21.
//

import Foundation

protocol LoginApiProtocol {
    func listOfUsers() -> [User]
}

class LoginApi: LoginApiProtocol {
    func listOfUsers() -> [User] {
        let users = [User(cpf: "111.111.111-11", password: "111"),
                     User(cpf: "222.222.222-22", password: "222"),
                     User(cpf: "333.333.333-33", password: "333")]
        return users
    }
}
