//
//  MockLoginRepository.swift
//  AppTests
//
//  Created by ACT on 02/02/22.
//

import Foundation
import Login

class MockLoginRepository: LoginRepositoryProtocol{
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
    
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
    
    
}
