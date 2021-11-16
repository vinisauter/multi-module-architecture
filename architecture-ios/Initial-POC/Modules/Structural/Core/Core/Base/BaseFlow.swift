//
//  BaseFlow.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public struct Deeplink<T> {
    public let screen: T?
    public let url: URL?
    
    public init(screen: T?, url: URL?) {
        self.screen = screen
        self.url = url
    }
}

public enum JourneyModule: String, CaseIterable {
    case unknown = "unknown"
    case login = "login"
    case home = "home"
    case profile = "profile"
    
    public static func from(_ deeplink: String) -> (jorney: JourneyModule, urlComponents: URL?) {
        guard  let url = URL(string: deeplink), let host = url.host else { return (.unknown, nil) }
                
        return (JourneyModule(rawValue: host) ?? .unknown, url)
    }
}

public protocol Deeplinkable: AnyObject {
    func resolveDeeplinkIfNeeded(from controller: UIViewController)
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

