//
//  ChipBusinessModel+Analytics.swift
//  ChipFramework
//
//  Created by Avanade on 22/12/21.
//

extension ChipBusinessModel: ChipAnalyticsProtocol {
    func onOpenProfileClick() {
        structuralAnalytics?.track(tag: "PROFILE PAGE - onClickButton")
    }
    
    func onClickChip() {
        structuralAnalytics?.track(tag: "Chip HOME - onClickChip track")
    }
}
