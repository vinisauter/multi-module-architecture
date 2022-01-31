//
//  HomeViewModel.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol HomeIndexViewModelProtocol: HomeIndexBusinessModelProtocol, HomeIndexFlowDelegate {}

class HomeIndexViewModel: BaseViewModel<HomeIndexBusinessModelProtocol, HomeIndexAnalyticsProtocol, HomeIndexFlowDelegate>, HomeIndexViewModelProtocol {
    func openProfile(in controller: HomeIndexViewController) {
        analytics?.onOpenProfileClick()
        flowDelegate?.openProfile(in: controller)
    }
    
    func logout(in controller: HomeIndexViewController) {
        analytics?.onLogoutClick()
        flowDelegate?.logout(in: controller)
    }
}
