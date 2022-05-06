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

public protocol AppNavigationDataSource {
    func get(_ journey: Journey, customAnalytics: Any?, completion: @escaping (BaseFlowDelegateAction, UIViewController, Any?) -> Void) -> UIViewController
}

public protocol ModuleHandlerNavigationDelegate: AnyObject {
    func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?)
}

public protocol ModuleHandlerProtocol: AnyObject {
    var navigationDelegate: ModuleHandlerNavigationDelegate? { get set }
    var navigationDataSource: AppNavigationDataSource? { get set }
    var completionHandler: ((BaseFlowDelegateAction, UIViewController, Any?) -> Void)? { get set }
     
    func launch(fromURL url: URL?, withCustomAnalytics customAnalytics: Any?, subJourney: Journey?, andValue value: Any?) -> UIViewController
    func canStart() -> Bool
    func getName() -> String
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigationProtocol)
    func handleFinish(in viewController: UIViewController, with value: Any?, andAppNavigation appNavigation: AppNavigationProtocol)
}
