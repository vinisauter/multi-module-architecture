//
//  HomeBusinessModel.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol HomeUseCaseProtocol: HomeIndexUseCaseProtocol {
    var repository: HomeRepositoryProtocol { get }
}

class HomeBusinessModel: HomeUseCaseProtocol {
    internal var repository: HomeRepositoryProtocol
    internal var analytics: String
    
    init(repository: HomeRepositoryProtocol, analytics: String) {
        self.repository = repository
        self.analytics = analytics
    }
}
