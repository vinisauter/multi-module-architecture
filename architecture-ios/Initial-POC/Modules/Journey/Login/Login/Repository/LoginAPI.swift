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
    
    func login(with username: String, and password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        var request: URLRequest = URLRequest(url: URL(string: "http://www.example.com/")!)
        request.httpMethod = "POST"
        request.addValue("\(username):\(password)", forHTTPHeaderField: "Authorization")
        
        secureHttpClient.post(request) { result in
            completion(result)
        }
        
        print(" >>>> METHOD 1 from \(self)")
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        var request: URLRequest = URLRequest(url: URL(string: "http://www.example.com/")!)
        request.httpMethod = "POST"
        request.addValue("password:\(newPassword)", forHTTPHeaderField: "Authorization")
        
        insecureHttpClient.post(request) { result in
            completion(result)
        }
        print(" >>>> METHOD 2 from \(self)")
    }
    
    func saveLogin(username: String, password: String, completion: @escaping (Result<String, ThirdPartyLibraryError>) -> Void) {
        if username.count > 0 && password.count > 0 {
            completion(.success("success"))
        } else {
            completion(.failure(.error))
        }
    }
}

public enum ThirdPartyLibraryError: Error, Equatable {
    case error
}
