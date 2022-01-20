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
    
    init(repository: HomeRepositoryProtocol, structuralAnalytics: AnalyticsProtocol) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
}

extension HomeBusinessModel: HomeIndexBusinessModelProtocol {}
