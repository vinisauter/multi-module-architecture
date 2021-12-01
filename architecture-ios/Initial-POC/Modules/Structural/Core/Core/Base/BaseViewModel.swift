//
//  BaseViewModel.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

public protocol BaseViewModelProtocol {
    var isIndex: Bool { get set }
    func getUseCase<UseCase>() -> UseCase?
    func getAnalytics<AnalyticsModel>() -> AnalyticsModel?
    func getFlow<FlowDelegate>() -> FlowDelegate?
}

public protocol ViewModelProtocol: BaseViewModelProtocol {
    associatedtype UseCase
    associatedtype AnalyticsModel
    associatedtype FlowDelegate

    var useCase: UseCase? { get }
    var analytics: AnalyticsModel? { get }
    var flowDelegate: FlowDelegate? { get set }
}

open class BaseViewModel<U, A, F>: ViewModelProtocol {
    public typealias UseCase = U
    public typealias AnalyticsModel = A
    public typealias FlowDelegate = F
    
    public var useCase: UseCase?
    public var analytics: AnalyticsModel?
    public var flowDelegate: FlowDelegate?
    public var isIndex: Bool = false
    
    public init(useCase: UseCase?, analytics: AnalyticsModel?, flowDelegate: FlowDelegate?, isIndex: Bool = false) {
        self.useCase = useCase
        self.analytics = analytics
        self.flowDelegate = flowDelegate
        self.isIndex = isIndex
    }
    
    public func getUseCase<UseCase>() -> UseCase? {
        return useCase as? UseCase
    }
    
    public func getAnalytics<AnalyticsModel>() -> AnalyticsModel? {
        return analytics as? AnalyticsModel
    }
    
    public func getFlow<FlowDelegate>() -> FlowDelegate? {
        return flowDelegate as? FlowDelegate
    }
}
