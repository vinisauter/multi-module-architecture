//
//  BaseViewModel.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public protocol BaseViewModelProtocol {
    func checkDeeplinkIfNeeded(fromViewController viewController: UIViewController)
}

public protocol ViewModelProtocol: BaseViewModelProtocol {
    associatedtype BusinessModel
    associatedtype AnalyticsModel
    associatedtype FlowDelegate

    var businessModel: BusinessModel? { get }
    var analytics: AnalyticsModel? { get }
    var flowDelegate: FlowDelegate? { get set }
    var isIndex: Bool { get set }
}

open class BaseViewModel<BusinessModel, AnalyticsModel, FlowDelegate>: ViewModelProtocol {    
    public var businessModel: BusinessModel?
    public var analytics: AnalyticsModel?
    public var flowDelegate: FlowDelegate?
    public var isIndex: Bool = false
    
    public init(businessModel: BusinessModel?, analytics: AnalyticsModel?, flowDelegate: FlowDelegate?, isIndex: Bool = false) {
        self.businessModel = businessModel
        self.analytics = analytics
        self.flowDelegate = flowDelegate
        self.isIndex = isIndex
    }
    
    public func checkDeeplinkIfNeeded(fromViewController viewController: UIViewController) {
        if let flowDelegate = flowDelegate as? Deeplinkable, isIndex {
            flowDelegate.resolveDeeplinkIfNeeded(from: viewController)
        }
    }
}
