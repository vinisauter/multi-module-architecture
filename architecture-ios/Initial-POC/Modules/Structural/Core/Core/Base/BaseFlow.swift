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

public protocol JourneyModuleAnalyticsProtocol {}
// app://login/*
// app://welcome/*
// app://home/*
// app://profile/*
public enum JourneyModule: String, CaseIterable {
    case welcome = "welcome"
    case login = "login"
    case forgotPassword = "forgotPassword"
    case home = "home"
    case profile = "profile"
    case detail = "detail"
    
    public var shouldBeLogInToOpen: Bool {
        switch self {
        case .welcome: return false
        case .login: return false
        case .forgotPassword: return false
        case .home: return true
        case .profile: return true
        case .detail: return true
        }
    }
    
    public static func from(_ deeplink: String) -> (jorney: JourneyModule, urlComponents: URL?) {
        guard  let url = URL(string: deeplink), let host = url.host else { return (.welcome, nil) }
                
        return (JourneyModule(rawValue: host) ?? .welcome, url)
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
    func get(_ journey: JourneyModule, from currentJourney: JourneyModule, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: JourneyModuleAnalyticsProtocol?) -> UIViewController
}

