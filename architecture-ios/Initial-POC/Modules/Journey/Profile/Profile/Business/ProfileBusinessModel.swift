//
//  ProfileBusinessModel.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import AnalyticsInterfaces

public protocol ProfileUseCaseProtocol: ProfileHomeUseCaseProtocol {
    var repository: ProfileRepositoryProtocol { get }
}

class ProfileBusinessModel: ProfileUseCaseProtocol {
    internal var repository: ProfileRepositoryProtocol
    internal var analytics: AnalyticsProtocol
    
    init(repository: ProfileRepositoryProtocol, analytics: AnalyticsProtocol) {
        self.repository = repository
        self.analytics = analytics
    }
}
