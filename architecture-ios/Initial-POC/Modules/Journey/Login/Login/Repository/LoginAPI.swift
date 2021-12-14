//
//  LoginAPI.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces

class LoginAPI: LoginRepositoryProtocol {
    private let network: NetworkingProviderProtocol
    
    init(network: NetworkingProviderProtocol) {
        self.network = network
    }
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return completion(false) }
            print("======> login: \(self.network.getHTTPClient(.secure).post())")
            completion(self.network.getHTTPClient(.secure).post() == "Secure POST")
        }
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return completion(false) }
            print("======> changePassword: \(self.network.getHTTPClient(.someLib).post())")
            completion(self.network.getHTTPClient(.someLib).post() == "POST")
        }
    }
}
