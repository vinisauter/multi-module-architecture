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
    public var isSubJourney: Bool = false
    
    public init(rawValue: String, isSubJourney: Bool) {
        self.rawValue = rawValue
        self.isSubJourney = isSubJourney
    }
    
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

public protocol ModuleHandler {
    var appNavigation: AppNavigation? { get }
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)? { get }
     
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, value: Any?, appNavigation: AppNavigation, andCompletionHandler completion: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)?) -> UIViewController
    func canStart() -> Bool
    func getName() -> String
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)
    func handleFinish(in viewController: UIViewController, with value: Any?)
}
