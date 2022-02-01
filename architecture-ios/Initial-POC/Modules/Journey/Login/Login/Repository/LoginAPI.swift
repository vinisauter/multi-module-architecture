//
//  LoginAPI.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces

class LoginAPI: LoginRepositoryProtocol {
    private let secureHttpClient: HTTPClientProtocol
    private let insecureHttpClient: HTTPClientProtocol
    
    init(secureHttpClient: HTTPClientProtocol, insecureHttpClient: HTTPClientProtocol) {
        self.secureHttpClient = secureHttpClient
        self.insecureHttpClient = insecureHttpClient
        print(" >>>> INIT from \(self)")
    }
    
    deinit {
        print(" >>>> DEINIT from \(self)")
    }
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        var request: URLRequest = URLRequest(url: URL(string: "http://www.example.com/")!)
        request.httpMethod = "POST"
        request.addValue("\(username):\(password)", forHTTPHeaderField: "Authorization")
        
        secureHttpClient.post(request) { result in
            completion(result == "valid")
        }
        
        print(" >>>> METHOD 1 from \(self)")
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        var request: URLRequest = URLRequest(url: URL(string: "http://www.example.com/")!)
        request.httpMethod = "POST"
        request.addValue("password:\(newPassword)", forHTTPHeaderField: "Authorization")
        
        insecureHttpClient.post(request) { result in
            completion(result == "valid")
        }
        print(" >>>> METHOD 2 from \(self)")
    }
}
