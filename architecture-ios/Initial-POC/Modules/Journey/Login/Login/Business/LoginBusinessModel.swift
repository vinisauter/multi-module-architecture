//
//  LoginBusinessModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core
import AnalyticsInterfaces

public protocol LoginAnalyticsProtocol {
    var structuralAnalytics: AnalyticsProtocol? { get }
}

public protocol LoginBusinessModelProtocol {
    var repository: LoginRepositoryProtocol? { get }
}

class LoginBusinessModel: LoginBusinessModelProtocol, LoginAnalyticsProtocol {
    internal var repository: LoginRepositoryProtocol?
    internal var structuralAnalytics: AnalyticsProtocol?
    
    init(repository: LoginRepositoryProtocol, structuralAnalytics: AnalyticsProtocol) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
}

extension LoginBusinessModel: LoginIndexBusinessModelProtocol {
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        repository?.login(with: username, and: password, completion: completion)
    }
}

extension LoginBusinessModel: ForgotPasswordBusinessModelProtocol {
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        repository?.changePassword(with: newPassword, completion: completion)
    }
}
