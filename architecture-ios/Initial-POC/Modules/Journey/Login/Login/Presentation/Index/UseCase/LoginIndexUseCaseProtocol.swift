//
//  LoginIndexUseCaseProtocol.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 01/12/21.
//

import Foundation

public protocol LoginIndexUseCaseProtocol {
    func login(with username: String, and password: String, completion: @escaping (_ success: Bool) -> Void)
}
