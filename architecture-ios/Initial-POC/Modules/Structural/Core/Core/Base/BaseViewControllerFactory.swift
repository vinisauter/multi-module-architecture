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
    open var businessModel: BusinessModel?
    open var analytics: Analytics?
    
    public init(businessModel: BusinessModel?, analytics: Analytics?) {
        self.businessModel = businessModel
        self.analytics = analytics
    }
    
    open func getViewControllerFromStoryboard<T: UIViewController>(in storyboardName: String) -> T? {
        guard let viewController = UIViewController.instantiateViewController(ofType: T.self, in: storyboardName) else {
            debugPrint("The \(T.self) cannot be initialized")
            return nil
        }
        
        return viewController
    }
}
