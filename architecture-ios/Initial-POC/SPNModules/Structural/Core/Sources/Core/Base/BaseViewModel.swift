//
//  BaseViewModel.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

public protocol BaseViewModelProtocol {
    var isIndex: Bool { get set }
    func getBusinessModel<BusinessModel>() -> BusinessModel?
    func getAnalytics<AnalyticsModel>() -> AnalyticsModel?
    func getFlow<FlowDelegate>() -> FlowDelegate?
}

public protocol ViewModelProtocol: BaseViewModelProtocol {
    associatedtype BusinessModel
    associatedtype AnalyticsModel
    associatedtype FlowDelegate

    var businessModel: BusinessModel? { get }
    var analytics: AnalyticsModel? { get }
    var flowDelegate: FlowDelegate? { get set }
}

open class BaseViewModel<U, A, F>: ViewModelProtocol {
    public typealias BusinessModel = U
    public typealias AnalyticsModel = A
    public typealias FlowDelegate = F
    
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
    
    public func getBusinessModel<BusinessModel>() -> BusinessModel? {
        return businessModel as? BusinessModel
    }
    
    public func getAnalytics<AnalyticsModel>() -> AnalyticsModel? {
        return analytics as? AnalyticsModel
    }
    
    public func getFlow<FlowDelegate>() -> FlowDelegate? {
        return flowDelegate as? FlowDelegate
    }
}
