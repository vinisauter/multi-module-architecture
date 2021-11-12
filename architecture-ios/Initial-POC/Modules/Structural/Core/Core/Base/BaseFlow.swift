//
//  BaseFlow.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public enum JourneyModule: String, CaseIterable {
    case unknown = "unknown"
    case login = "login"
    case home = "home"
    case profile = "profile"
    
    public static func from(_ deeplink: String) -> JourneyModule {
        let urlComponents = URLComponents(string: deeplink)
        guard let host = urlComponents?.host else { return .unknown }
        
        return JourneyModule.allCases.first{ $0.rawValue == host } ?? .unknown
    }
}

public protocol BaseFlowDelegate: AnyObject {
    func didFinish(_ feature: JourneyModule, in viewController: UIViewController, with value: Any?)
    func go(to destinationJourney: JourneyModule, from currentJourney: JourneyModule, in viewController: UIViewController, with value: Any?)
}

public extension BaseFlowDelegate {
    func didFinish(_ feature: JourneyModule, in viewController: UIViewController, with value: Any?) {}
    func go(to destinationJourney: JourneyModule, from currentJourney: JourneyModule, in viewController: UIViewController, with value: Any?) {}
}

public protocol BaseFlowDataSource: AnyObject {
    func get(_ journey: JourneyModule, from currentJourney: BaseFlowDelegate) -> UIViewController
}

