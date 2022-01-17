//
//  LoginAnalyticsProfileAdapter.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 18/11/21.
//

import AnalyticsInterfacesFramework
import CoreFramework
import LoginFramework
import ProfileFramework

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
