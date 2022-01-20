//
//  ProfileViewControllersFactory.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public class ProfileViewControllerFactory: BaseViewControllerFactory<ProfileBusinessModel, ProfileAnalyticsProtocol> {
    weak var flow: ProfileFlowProtocol?
    
    func makeProfileHomeViewController(isIndex: Bool = false) -> ProfileHomeViewController {
        let viewModel = ProfileHomeViewModel(businessModel: businessModel, analytics: defaultAnalytics as? ProfileHomeAnalyticsProtocol, flowDelegate: flow as? ProfileHomeFlowDelegate)
        viewModel.isIndex = isIndex
        return ProfileHomeViewController(viewModel: viewModel)
    }
}
