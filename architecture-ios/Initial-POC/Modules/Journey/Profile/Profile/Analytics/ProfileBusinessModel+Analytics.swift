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
        analytics?.track(tag: "PROFILE INDEX - onGoToMenuClick track")
    }
    
    func onCallLoginClick() {
        analytics?.track(tag: "PROFILE INDEX - onCallLoginClick track")
    }
}

extension ProfileBusinessModel {
    func onLoginClick() {
        analytics?.track(tag: "FROM PROFILE - LOGIN - onLoginClick track ")
    }
    
    func onForgotPasswordClick() {
        analytics?.track(tag: "FROM PROFILE - LOGIN - onForgotPasswordClick track")
    }
    
    func onChangePasswordClick() {
        analytics?.track(tag: "FROM PROFILE - LOGIN/FORGOT PASSWORD - onChangePasswordClick track")
    }
}
