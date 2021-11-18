//
//  UserModel.swift
//  Login
//
//  Created by Felippe Matos on 11/11/21.
//

import Foundation

public class User {
    var cpf: String
    var password: String
    
    public init(cpf: String, password: String) {
        self.cpf = cpf
        self.password = password
    }
}
