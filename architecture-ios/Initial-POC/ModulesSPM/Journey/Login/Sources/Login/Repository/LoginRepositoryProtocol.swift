//
//  LoginRepositoryProtocol.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol LoginRepositoryProtocol {
    func login(with username: String, and password: String, completion: @escaping (_ success: Bool) -> Void)
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void)
}
