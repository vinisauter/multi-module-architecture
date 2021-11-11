//
//  LoginBusinessModel+Analytics.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

public protocol LoginAnalyticsProtocol: LoginIndexAnalyticsProtocol {
    var analytics: AnalyticsProtocol { get }
}

extension LoginBusinessModel: LoginAnalyticsProtocol {
    func onLoginClick() {
        analytics.track(tag: "LOGIN - onLoginClick track")
    }
}
