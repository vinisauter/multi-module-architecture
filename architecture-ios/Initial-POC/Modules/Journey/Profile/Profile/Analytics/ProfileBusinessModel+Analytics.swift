//
//  ProfileBusinessModel+Analytics.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

public protocol ProfileAnalyticsProtocol: ProfileHomeAnalyticsProtocol {
    var analytics: AnalyticsProtocol { get }
}

extension ProfileBusinessModel: ProfileAnalyticsProtocol {
    func onGoToMenuClick() {
        analytics.track(tag: "PROFILE INDEX - onGoToMenuClick track")
    }
}
