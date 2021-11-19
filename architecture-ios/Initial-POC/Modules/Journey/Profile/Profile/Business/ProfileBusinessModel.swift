//
//  ProfileBusinessModel.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core
import AnalyticsInterfaces

public protocol ProfileAnalyticsProtocol: JourneyModuleAnalyticsProtocol {
    var analytics: AnalyticsProtocol? { get }
    func onLoginClick()
    func onForgotPasswordClick()
    func onChangePasswordClick()
}

public protocol ProfileUseCaseProtocol {
    var repository: ProfileRepositoryProtocol? { get }
}

class ProfileBusinessModel: ProfileUseCaseProtocol, ProfileAnalyticsProtocol {
    internal var repository: ProfileRepositoryProtocol?
    internal var analytics: AnalyticsProtocol?
    
    init(repository: ProfileRepositoryProtocol, analytics: AnalyticsProtocol) {
        self.repository = repository
        self.analytics = analytics
    }
}
