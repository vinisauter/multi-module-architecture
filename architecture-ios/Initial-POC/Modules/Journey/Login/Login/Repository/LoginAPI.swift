//
//  LoginAPI.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces

class LoginAPI: LoginRepositoryProtocol {
    // Não tem como testar
    private let secureHttpClient: HTTPClientProtocol
    private let insecureHttpClient: HTTPClientProtocol
    
    init(secureHttpClient: HTTPClientProtocol, insecureHttpClient: HTTPClientProtocol) {
        self.secureHttpClient = secureHttpClient
        self.insecureHttpClient = insecureHttpClient
    }
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        secureHttpClient.post("username:\(username) password:\(password)") { result in
            completion(result == "Passed")
        }
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        insecureHttpClient.post("some_url") { result in
            completion(result == "POST")
        }
    }
}
