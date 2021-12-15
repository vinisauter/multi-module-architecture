//
//  LoginAPI.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces
import NSecurityInterfaces

class LoginAPI: LoginRepositoryProtocol {
    private let secureHttpClient: HTTPClientProtocol
    private let insecureHttpClient: HTTPClientProtocol
    private let certificate: String
    
    init(secureHttpClient: HTTPClientProtocol, insecureHttpClient: HTTPClientProtocol, certificate: String) {
        self.secureHttpClient = secureHttpClient
        self.insecureHttpClient = insecureHttpClient
        self.certificate = certificate
    }
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        secureHttpClient.post("some_url", certificate: certificate) { result in
            completion(result == "POST")
        }
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        insecureHttpClient.post("some_url", certificate: certificate) { result in
            completion(result == "POST")
        }
    }
}
