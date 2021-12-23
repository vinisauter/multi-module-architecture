//
//  VaquinhaBusinessModel.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import AnalyticsInterfaces

public protocol VaquinhaStructuralAnalyticsProtocol {
    var structuralAnalytics: AnalyticsProtocol? { get }
}

class VaquinhaBusinessModel: VaquinhaStructuralAnalyticsProtocol {
    var structuralAnalytics: AnalyticsProtocol?
    var repository: VaquinhaRepositoryProtocol?
    
    init(repository: VaquinhaRepositoryProtocol, structuralAnalytics: AnalyticsProtocol) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
}

extension VaquinhaBusinessModel: VaquinhaBusinessModelProtocol {}
