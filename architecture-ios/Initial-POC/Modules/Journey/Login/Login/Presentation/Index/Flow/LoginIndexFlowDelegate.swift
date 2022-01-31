//
//  LoginIndexFlowDelegate.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 01/12/21.
//

import Foundation

public protocol LoginIndexFlowDelegate: AnyObject {
    func onLoginSuccess(in controller: LoginIndexViewController)
    func onForgotPasswordClick(in controller: LoginIndexViewController)
    func onCloseClick(in controller: LoginIndexViewController)
    func onBackClick(in controller: LoginIndexViewController)
}
