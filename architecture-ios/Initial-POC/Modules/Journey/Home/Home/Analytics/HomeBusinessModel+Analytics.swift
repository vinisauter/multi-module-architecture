//
//  HomeBusinessModel+Analytics.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

public protocol HomeAnalyticsProtocol: HomeIndexAnalyticsProtocol {
    var analytics: AnalyticsProtocol { get }
}

extension HomeBusinessModel: HomeAnalyticsProtocol {
    func onOpenProfileClick() {
        analytics.track(tag: "HOME INDEX - onOpenProfileClick track")
    }
}
