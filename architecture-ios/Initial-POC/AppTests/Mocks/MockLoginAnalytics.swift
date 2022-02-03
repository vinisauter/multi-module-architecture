//
//  MockLoginAnalytics.swift
//  AppTests
//
//  Created by ACT on 02/02/22.
//

import Foundation
import Login
import Analytics
import AnalyticsInterfaces

class MockLoginStructuralAnaltytics: AnalyticsProtocol{
    func track(tag: String) {
        print("login analytics : \(tag)")
    }
}

class MockLoginAnalytics: LoginAnalyticsProtocol{
    public var structuralAnalytics: AnalyticsProtocol?
}
