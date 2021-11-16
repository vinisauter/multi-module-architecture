//
//  LoginBusinessModel+Analytics.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

public protocol LoginAnalyticsProtocol: LoginIndexAnalyticsProtocol, ForgotPasswordAnalyticsProtocol {
    var analytics: AnalyticsProtocol { get }
}

extension LoginBusinessModel: LoginAnalyticsProtocol {
    func onLoginClick() {
        analytics.track(tag: "LOGIN - onLoginClick track")
    }
}

extension LoginBusinessModel: ForgotPasswordAnalyticsProtocol {
    func onChangePasswordClick() {
        analytics.track(tag: "LOGIN/FORGOT PASSWORD - onChangePasswordClick track")
    }
}
