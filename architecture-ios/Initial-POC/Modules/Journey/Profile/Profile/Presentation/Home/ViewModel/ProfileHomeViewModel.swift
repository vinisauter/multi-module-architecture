//
//  ProfileHomeViewModel.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol ProfileHomeViewModelProtocol: ProfileHomeBusinessModelProtocol, ProfileHomeFlowDelegate {}

class ProfileHomeViewModel: BaseViewModel<ProfileHomeBusinessModelProtocol, ProfileHomeAnalyticsProtocol, ProfileHomeFlowDelegate>, ProfileHomeViewModelProtocol {
    func goToHome(in controller: ProfileHomeViewController) {
        analytics?.onGoToMenuClick()
        flowDelegate?.goToHome(in: controller)
    }
    
    func callLogin(in controller: ProfileHomeViewController) {
        analytics?.onCallLoginClick()
        flowDelegate?.callLogin(in: controller)
    }
    
    func goToForgotPassword(in controller: ProfileHomeViewController) {
        analytics?.onGoToForgotPasswordClick()
        flowDelegate?.goToForgotPassword(in: controller)
    }
}
