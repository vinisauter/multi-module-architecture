//
//  VaquinhaBusinessModel+Analytics.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

extension VaquinhaBusinessModel: VaquinhaAnalyticsProtocol {
    func onOpenProfileClick() {
        structuralAnalytics?.track(tag: "PROFILE PAGE - onClickButton")
    }
    
    func onClickVaquinha() {
        structuralAnalytics?.track(tag: "VAQUINHA HOME - onClickVaquinha track")
    }
}
