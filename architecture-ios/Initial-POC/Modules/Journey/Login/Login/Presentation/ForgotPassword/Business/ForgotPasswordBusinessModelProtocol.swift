//
//  ForgotPasswordBusinessModelProtocol.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 01/12/21.
//

import Foundation

public protocol ForgotPasswordBusinessModelProtocol {
    func changePassword(with newPassword: String, completion: @escaping (_ success: Bool) -> Void)
}
