//
//  HomeBusinessModel.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core
import AnalyticsInterfaces

public protocol HomeAnalyticsProtocol {
    var structuralAnalytics: AnalyticsProtocol? { get }
}

public class HomeBusinessModel: HomeAnalyticsProtocol {
    public var repository: HomeRepositoryProtocol?
    public var structuralAnalytics: AnalyticsProtocol?
    private let value: Dictionary<String, Any>?
    
    init(repository: HomeRepositoryProtocol, structuralAnalytics: AnalyticsProtocol, value: Dictionary<String, Any>?) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
        self.value = value
    }
}

extension HomeBusinessModel: HomeIndexBusinessModelProtocol {
    public func getUsername() -> String {
        return value?["username"] as? String ?? ""
    }
}
