//
//  LoginBusinessModel.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core
import AnalyticsInterfaces

public protocol LoginAnalyticsProtocol: JourneyModuleAnalyticsProtocol {
    var analytics: AnalyticsProtocol? { get }
}

public protocol LoginUseCaseProtocol {
    var repository: LoginRepositoryProtocol? { get }
}

class LoginBusinessModel: LoginUseCaseProtocol, LoginAnalyticsProtocol {
    internal var repository: LoginRepositoryProtocol?
    internal var analytics: AnalyticsProtocol?
    
    init(repository: LoginRepositoryProtocol, analytics: AnalyticsProtocol) {
        self.repository = repository
        self.analytics = analytics
    }
}

extension LoginBusinessModel: LoginIndexUseCaseProtocol {
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        repository?.login(with: username, and: password, completion: completion)
    }
}

extension LoginBusinessModel: ForgotPasswordUseCaseProtocol {
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        repository?.changePassword(with: newPassword, completion: completion)
    }
}
