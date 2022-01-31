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


public class LoginBusinessModel: LoginAnalyticsProtocol {
    public var repository: LoginRepositoryProtocol?
    public var structuralAnalytics: AnalyticsProtocol?
    
    init(repository: LoginRepositoryProtocol, structuralAnalytics: AnalyticsProtocol) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
}

extension LoginBusinessModel: LoginIndexBusinessModelProtocol {
    public func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        repository?.login(with: username, and: password, completion: { result in
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
}

extension LoginBusinessModel: ForgotPasswordBusinessModelProtocol {
    public func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        repository?.changePassword(with: newPassword, completion: { result in
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
}
