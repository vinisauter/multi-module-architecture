//
//  LoginBusinessModel+Analytics.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol LoginAnalyticsProtocol: LoginIndexAnalyticsProtocol {
    var analytics: String { get }
}

extension LoginBusinessModel: LoginAnalyticsProtocol {
    func onLoginClick() {
        debugPrint("LOGIN: onLoginClick track")
    }
}
