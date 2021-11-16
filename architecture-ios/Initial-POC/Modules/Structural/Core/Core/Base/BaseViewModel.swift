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
}

public protocol ViewModelProtocol: BaseViewModelProtocol {
    associatedtype UseCase
    associatedtype AnalyticsModel
    var useCase: UseCase? { get }
    var analytics: AnalyticsModel? { get }
}

open class BaseViewModel<U, A, D>: ViewModelProtocol {
    public typealias UseCase = U
    public typealias AnalyticsModel = A
    
    public var useCase: UseCase?
    public var analytics: AnalyticsModel?
    public var isIndex: Bool = false
    public var deeplink: D?
    
    public init(useCase: UseCase?, analytics: AnalyticsModel?, isIndex: Bool = false) {
        self.useCase = useCase
        self.analytics = analytics
        self.isIndex = isIndex
    }
    
    public func getUseCase<UseCase>() -> UseCase? {
        return useCase as? UseCase
    }
    
    public func getAnalytics<AnalyticsModel>() -> AnalyticsModel? {
        return analytics as? AnalyticsModel
    }
}
