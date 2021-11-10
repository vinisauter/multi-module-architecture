//
//  LoginBusinessModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol LoginUseCaseProtocol: LoginIndexUseCaseProtocol {
    var repository: LoginRepositoryProtocol { get }
}

class LoginBusinessModel: LoginUseCaseProtocol {
    internal var repository: LoginRepositoryProtocol
    internal var analytics: String
    
    init(repository: LoginRepositoryProtocol, analytics: String) {
        self.repository = repository
        self.analytics = analytics
    }
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        repository.login(with: username, and: password, completion: completion)
    }
}
