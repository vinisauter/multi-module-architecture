//
//  ProfileHomeViewModel.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol ProfileHomeUseCaseProtocol {

}

public protocol ProfileHomeAnalyticsProtocol {
    func onGoToMenuClick()
    func onCallLoginClick()
}

public protocol ProfileHomeViewModelProtocol {
    func onGoToMenuClick()
    func onCallLoginClick()
}

class ProfileHomeViewModel: BaseViewModel<ProfileHomeUseCaseProtocol, ProfileHomeAnalyticsProtocol, ProfileDeeplink>, ProfileHomeViewModelProtocol {
    func onGoToMenuClick() {
        analytics?.onGoToMenuClick()
    }
    
    func onCallLoginClick() {
        analytics?.onCallLoginClick()
    }
}
