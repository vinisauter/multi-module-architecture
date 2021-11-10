//
//  BaseFlowDelegate.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public struct JourneyModule: RawRepresentable, Equatable, Hashable {
    public static let login: JourneyModule = JourneyModule(rawValue: "login")
    public static let home: JourneyModule = JourneyModule(rawValue: "home")
    public static let profile: JourneyModule = JourneyModule(rawValue: "profile")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public protocol BaseFlowDelegate: AnyObject {
    func didFinish(_ feature: JourneyModule, in viewController: UIViewController, with value: Any?)
}
