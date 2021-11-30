//
//  ProfileViewControllersFactory.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public class ProfileViewControllerFactory: BaseViewControllerFactory<ProfileUseCaseProtocol, ProfileAnalyticsProtocol> {
    weak var flow: ProfileFlowProtocol?
    
    func makeProfileHomeViewController(isIndex: Bool = false) -> ProfileHomeViewController {
        let viewModel = ProfileHomeViewModel(useCase: businessModel as? ProfileHomeUseCaseProtocol, analytics: defaultAnalytics as? ProfileHomeAnalyticsProtocol)
        viewModel.isIndex = isIndex
        return ProfileHomeViewController(viewModel: viewModel, flowDelegate: flow as? ProfileHomeFlowDelegate)
    }
}
