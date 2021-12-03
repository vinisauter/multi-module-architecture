//
//  LoginAPI.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces

class LoginAPI: LoginRepositoryProtocol {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        httpClient.post { result in
            completion(result == "POST")
        }
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        httpClient.post { result in
            completion(result == "POST")
        }
    }
}
