//
//  LoginBusinessModel+Analytics.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

extension LoginBusinessModel: LoginIndexAnalyticsProtocol {
    public func onForgotPasswordClick() {
        structuralAnalytics?.track(tag: "LOGIN - onForgotPassword track")
    }
    
    public func onLoginClick() {
        structuralAnalytics?.track(tag: "LOGIN - onLoginClick track")
    }
}

extension LoginBusinessModel: ForgotPasswordAnalyticsProtocol {
    public func onChangePasswordClick() {
        structuralAnalytics?.track(tag: "LOGIN/FORGOT PASSWORD - onChangePasswordClick track")
    }
}
