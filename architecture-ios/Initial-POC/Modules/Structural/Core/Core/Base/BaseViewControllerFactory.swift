//
//  BaseViewControllerFactory.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public protocol BaseViewControllerFactoryProtocol {
    associatedtype BusinessModel
    associatedtype Analytics
    var businessModel: BusinessModel { get set }
    var defaultAnalytics: Analytics { get set }
    var customAnalytics: Analytics { get set }
}

open class BaseViewControllerFactory<BusinessModel, Analytics>: BaseViewControllerFactoryProtocol {
    public var businessModel: BusinessModel?
    public var defaultAnalytics: Analytics?
    public var customAnalytics: Analytics?
    
    public init(businessModel: BusinessModel?, defaultAnalytics: Analytics?, customAnalytics: Analytics?) {
        self.businessModel = businessModel
        self.defaultAnalytics = defaultAnalytics
        self.customAnalytics = customAnalytics
    }
    
    func getViewControllerFromStoryboard<T: UIViewController>(in storyboardName: String) -> T? {
        guard let viewController = UIViewController.instantiateViewController(ofType: T.self, in: storyboardName) else {
            print("The \(T.self) cannot be initialized")
            return nil
        }
        
        return viewController
    }
}
