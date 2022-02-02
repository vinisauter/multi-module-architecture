//
//  LoginRepositoryProtocol.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces

public protocol LoginRepositoryProtocol: AnyObject {
    func login(with username: String, and password: String, completion: @escaping (Result<String, NetworkError>) -> Void)
    func changePassword(with newPassword: String, completion: @escaping (Result<String, NetworkError>) -> Void)
}
