//
//  HomeViewControllersFactory.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Core

class HomeViewControllerFactory: BaseViewControllerFactory<HomeBusinessModel, HomeAnalyticsProtocol> {
    
    func makeHomeIndexViewController(flow: HomeFlowProtocol) -> HomeIndexViewController {
        return HomeIndexViewController(viewModel: HomeIndexViewModel(businessModel: businessModel, analytics: analytics as? HomeIndexAnalyticsProtocol, flowDelegate: flow as? HomeIndexFlowDelegate))
    }
}
