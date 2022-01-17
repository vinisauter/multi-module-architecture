//
//  LoginAnalyticsProfileAdapter.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 18/11/21.
//

import Core
import Analytics
import AnalyticsInterfaces
import Login
import Profile

class LoginAnalyticsProfileAdapter: LoginAnalyticsProtocol, LoginIndexAnalyticsProtocol, ForgotPasswordAnalyticsProtocol {
    
    var structuralAnalytics: AnalyticsProtocol? {
        return profileAnalytics?.structuralAnalytics
    }
    
    private let profileAnalytics: ProfileAnalyticsProtocol?
    
    init(profileAnalytics: Any?) {
        self.profileAnalytics = profileAnalytics as? ProfileAnalyticsProtocol
    }
    
    func onLoginClick() {
        profileAnalytics?.onLoginClick()
    }
    
    func onForgotPasswordClick() {
        profileAnalytics?.onForgotPasswordClick()
    }
    
    func onChangePasswordClick() {
        profileAnalytics?.onChangePasswordClick()
    }
}
