//
//  LoginBusinessModel+Analytics.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

extension LoginBusinessModel: LoginIndexAnalyticsProtocol {
    func onForgotPasswordClick() {
        analytics?.track(tag: "LOGIN - onForgotPassword track")
    }
    
    func onLoginClick() {
        analytics?.track(tag: "LOGIN - onLoginClick track")
    }
}

extension LoginBusinessModel: ForgotPasswordAnalyticsProtocol {
    func onChangePasswordClick() {
        analytics?.track(tag: "LOGIN/FORGOT PASSWORD - onChangePasswordClick track")
    }
}
