//
//  ForgotPasswordFlowDelegate.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 01/12/21.
//

import Foundation

public protocol ForgotPasswordFlowDelegate: AnyObject {
    func onChangePasswordSuccess(in controller: ForgotPasswordViewController)
}
