//
//  LoginAnalyticsProfileAdapter.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 18/11/21.
//

import AnalyticsInterfaces
import Core
import Login
import Profile

class LoginAnalyticsProfileAdapter: LoginAnalyticsProtocol, LoginIndexAnalyticsProtocol, ForgotPasswordAnalyticsProtocol {
    var analytics: AnalyticsProtocol? {
        return profileAnalytics?.analytics
    }
    
    private let profileAnalytics: ProfileAnalyticsProtocol?
    
    init(profileAnalytics: JourneyModuleAnalyticsProtocol?) {
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
