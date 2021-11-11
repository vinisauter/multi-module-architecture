//
//  HomeBusinessModel.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

public protocol HomeUseCaseProtocol: HomeIndexUseCaseProtocol {
    var repository: HomeRepositoryProtocol { get }
}

class HomeBusinessModel: HomeUseCaseProtocol {
    internal var repository: HomeRepositoryProtocol
    internal var analytics: AnalyticsProtocol
    
    init(repository: HomeRepositoryProtocol, analytics: AnalyticsProtocol) {
        self.repository = repository
        self.analytics = analytics
    }
}
