//
//  HomeLauncher.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core
import NetworkingInterfaces
import AnalyticsInterfaces

public class HomeLauncher {
    static public func start(baseFlowDelegate: BaseFlowDelegate?, httpClient: HTTPClient, analytics: AnalyticsProtocol) -> UIViewController {
        let businessModel = HomeBusinessModel(repository: HomeAPI(httpClient: httpClient), analytics: analytics)
        let factory = HomeViewControllerFactory(businessModel: businessModel, analytics: businessModel)
        let mainFlow = HomeFlow(factory: factory)
        mainFlow.baseFlowDelegate = baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start(useCase: businessModel, analytics: businessModel)
    }
}
