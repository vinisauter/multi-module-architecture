//
//  HomeViewControllersFactory.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public class HomeViewControllerFactory: BaseViewControllerFactory<HomeUseCaseProtocol, HomeAnalyticsProtocol> {
    weak var flow: HomeFlowProtocol?
    
    func makeHomeIndexViewController() -> HomeIndexViewController {
        return HomeIndexViewController(viewModel: HomeIndexViewModel(useCase: businessModel as? HomeIndexUseCaseProtocol, analytics: customAnalytics as? HomeIndexAnalyticsProtocol ?? defaultAnalytics as? HomeIndexAnalyticsProtocol, flowDelegate: flow as? HomeIndexFlowDelegate))
    }
}
