//
//  Analytics.swift
//  Analytics
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import Foundation
import AnalyticsInterfaces

public class Analytics: AnalyticsProtocol {
    
    public init() {}
    
    public func track(tag: String) {
        debugPrint("+++++ ANALYTICS: \(tag)")
    }
}
