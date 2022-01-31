//
//  HomeViewControllersFactory.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

public class HomeViewControllerFactory: BaseViewControllerFactory<HomeBusinessModel, HomeAnalyticsProtocol> {
    weak var flow: HomeFlowProtocol?
    
    func makeHomeIndexViewController() -> HomeIndexViewController {
        return HomeIndexViewController(viewModel: HomeIndexViewModel(businessModel: businessModel, analytics: customAnalytics as? HomeIndexAnalyticsProtocol ?? defaultAnalytics as? HomeIndexAnalyticsProtocol, flowDelegate: flow as? HomeIndexFlowDelegate))
    }
}
