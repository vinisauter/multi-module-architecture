//
//  HomeBusinessModel+Analytics.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

extension HomeBusinessModel: HomeIndexAnalyticsProtocol {
    func onOpenProfileClick() {
        structuralAnalytics?.track(tag: "HOME INDEX - onOpenProfileClick track")
    }
    
    func onLogoutClick() {
        structuralAnalytics?.track(tag: "HOME INDEX - onLogoutClick track")
    }
}
