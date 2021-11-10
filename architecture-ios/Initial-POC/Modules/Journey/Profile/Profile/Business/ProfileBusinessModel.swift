//
//  ProfileBusinessModel.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation

public protocol ProfileUseCaseProtocol: ProfileHomeUseCaseProtocol {
    var repository: ProfileRepositoryProtocol { get }
}

class ProfileBusinessModel: ProfileUseCaseProtocol {
    internal var repository: ProfileRepositoryProtocol
    internal var analytics: String
    
    init(repository: ProfileRepositoryProtocol, analytics: String) {
        self.repository = repository
        self.analytics = analytics
    }
}
