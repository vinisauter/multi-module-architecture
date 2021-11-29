//
//  ProfileBusinessModel+Analytics.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces
import Core

extension ProfileBusinessModel: ProfileHomeAnalyticsProtocol {
    public func onGoToMenuClick() {
        structuralAnalytics?.track(tag: "PROFILE INDEX - onGoToMenuClick track")
    }
    
    func onCallLoginClick() {
        structuralAnalytics?.track(tag: "PROFILE INDEX - onCallLoginClick track")
    }
    
    func onGoToForgotPasswordClick() {
        structuralAnalytics?.track(tag: "PROFILE INDEX - onGoToForgotPasswordClick track")
    }
}

extension ProfileBusinessModel {
    func onLoginClick() {
        structuralAnalytics?.track(tag: "FROM PROFILE - LOGIN - onLoginClick track ")
    }
    
    func onForgotPasswordClick() {
        structuralAnalytics?.track(tag: "FROM PROFILE - LOGIN - onForgotPasswordClick track")
    }
    
    func onChangePasswordClick() {
        structuralAnalytics?.track(tag: "FROM PROFILE - LOGIN/FORGOT PASSWORD - onChangePasswordClick track")
    }
}
