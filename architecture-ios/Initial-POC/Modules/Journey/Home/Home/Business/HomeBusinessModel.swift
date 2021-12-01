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

public protocol HomeBusinessModelProtocol {
    var repository: HomeRepositoryProtocol? { get }
}

class HomeBusinessModel: HomeBusinessModelProtocol, HomeAnalyticsProtocol {
    internal var repository: HomeRepositoryProtocol?
    internal var structuralAnalytics: AnalyticsProtocol?
    
    init(repository: HomeRepositoryProtocol, structuralAnalytics: AnalyticsProtocol) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
}
