//
//  HomeBusinessModel+Analytics.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

extension HomeBusinessModel: HomeIndexAnalyticsProtocol {
    public func onOpenProfileClick() {
        structuralAnalytics?.track(tag: "HOME INDEX - onOpenProfileClick track")
    }
    
    public func onOpenTaskClick() {
        structuralAnalytics?.track(tag: "HOME INDEX - onOpenTaskClick track")
    }
    
    public func onOpenNoteClick() {
        structuralAnalytics?.track(tag: "HOME INDEX - onOpenNoteClick track")
    }
    
    public func onLogoutClick() {
        structuralAnalytics?.track(tag: "HOME INDEX - onLogoutClick track")
    }
}
