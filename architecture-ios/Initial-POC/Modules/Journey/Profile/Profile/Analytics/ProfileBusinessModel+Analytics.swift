//
//  ProfileBusinessModel+Analytics.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol ProfileAnalyticsProtocol: ProfileHomeAnalyticsProtocol {
    var analytics: String { get }
}

extension ProfileBusinessModel: ProfileAnalyticsProtocol {
    func onGoToMenuClick() {
        debugPrint("PROFILE INDEX: onGoToMenuClick track")
    }
}
