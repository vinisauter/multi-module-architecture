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
    var analytics: Analytics { get set }
}

open class BaseViewControllerFactory<BusinessModel, Analytics>: BaseViewControllerFactoryProtocol {
    public var businessModel: BusinessModel?
    public var analytics: Analytics?
    
    public init(businessModel: BusinessModel?, analytics: Analytics?) {
        self.businessModel = businessModel
        self.analytics = analytics
    }
    
    func getViewControllerFromStoryboard<T: UIViewController>(in storyboardName: String) -> T? {
        guard let viewController = UIViewController.instantiateViewController(ofType: T.self, in: storyboardName) else {
            print("The \(T.self) cannot be initialized")
            return nil
        }
        
        return viewController
    }
}
