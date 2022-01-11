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


public struct Journey: Hashable, RawRepresentable {
    static let unkown: Journey = Journey(rawValue: "unkown")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public enum BaseFlowDelegateAction {
    case finish(_ currentJourney: Journey)
    case goTo(_ destinationJourney: Journey, currentJourney: Journey)
    case finishCurrentAndGoTo(_ destinationJourney: Journey, currentJourney: Journey)
}

public protocol Deeplinkable: AnyObject {
    func resolveDeeplinkIfNeeded(from controller: UIViewController)
}

public protocol BaseFlowDelegate: AnyObject {
    func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?)
}

public protocol BaseFlowDataSource: AnyObject {
    func get(_ journey: Journey, from currentJourney: Journey, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController
}

public protocol ModuleHandler {
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController
    func canStart() -> Bool
    func getName() -> String
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController
}
