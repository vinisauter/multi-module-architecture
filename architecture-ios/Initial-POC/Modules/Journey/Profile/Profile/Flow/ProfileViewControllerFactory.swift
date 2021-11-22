//
//  ProfileViewControllersFactory.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public class ProfileViewControllerFactory: BaseViewControllerFactory<ProfileUseCaseProtocol, ProfileAnalyticsProtocol> {
    weak var flow: ProfileFlowProtocol?
    
    func makeProfileHomeViewController() -> ProfileHomeViewController {
        return ProfileHomeViewController(viewModel: ProfileHomeViewModel(useCase: businessModel as? ProfileHomeUseCaseProtocol, analytics: defaultAnalytics as? ProfileHomeAnalyticsProtocol), flowDelegate: flow as? ProfileHomeFlowDelegate)
    }
}
