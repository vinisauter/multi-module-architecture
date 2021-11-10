//
//  HomeViewModel.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public protocol HomeIndexUseCaseProtocol {

}

public protocol HomeIndexAnalyticsProtocol {
    func onOpenProfileClick()
}

public protocol HomeIndexViewModelProtocol {
    func onOpenProfileButtonClick()
}

class HomeIndexViewModel: BaseViewModel<HomeIndexUseCaseProtocol, HomeIndexAnalyticsProtocol>, HomeIndexViewModelProtocol {
    func onOpenProfileButtonClick() {
        analytics?.onOpenProfileClick()
    }
}
