//
//  HomeBusinessModel+Analytics.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol HomeAnalyticsProtocol: HomeIndexAnalyticsProtocol {
    var analytics: String { get }
}

extension HomeBusinessModel: HomeAnalyticsProtocol {
    func onOpenProfileClick() {
        debugPrint("HOME INDEX: onOpenProfileClick track")
    }
}
