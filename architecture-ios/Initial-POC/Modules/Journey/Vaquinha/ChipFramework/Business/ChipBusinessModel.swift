//
//  ChipBusinessModel.swift
//  ChipFramework
//
//  Created by Avanade on 22/12/21.
//

import AnalyticsInterfaces

public protocol ChipStructuralAnalyticsProtocol {
    var structuralAnalytics: AnalyticsProtocol? { get }
}

class ChipBusinessModel: ChipStructuralAnalyticsProtocol {
    var structuralAnalytics: AnalyticsProtocol?
    var repository: ChipRepositoryProtocol?
    
    init(repository: ChipRepositoryProtocol, structuralAnalytics: AnalyticsProtocol) {
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
}

extension ChipBusinessModel: ChipBusinessModelProtocol {}
