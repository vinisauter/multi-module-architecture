//
//  BaseFlow.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public struct Deeplink<T> {
    public let value: T?
    public let url: URL?
    
    public init(value: T?, url: URL?) {
        self.value = value
        self.url = url
    }
}

public protocol JourneyModuleAnalyticsProtocol {}
// app://login/*
// app://welcome/*
// app://home/*
// app://profile/*
public enum JourneyModule: CaseIterable {
    case unknown
    case welcome
    case login
    case forgotPassword
    case home
    case profile
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

public protocol ModuleStarter {
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: JourneyModuleAnalyticsProtocol?, _ subJourney: JourneyModule?) -> UIViewController
    func canStart() -> Bool
    func getPath() -> String
    func handleGo(to journey: JourneyModule, in viewController: UIViewController, with value: Any?)
    func handleGet(from journey: JourneyModule, to subJourney: JourneyModule?, with baseFlowDelegate: BaseFlowDelegate, analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController
}
