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
    static public func start(from deeplink: URL?, baseFlowDelegate: BaseFlowDelegate?, httpClient: HTTPClient, analytics: AnalyticsProtocol, homeAnalytics: HomeAnalyticsProtocol?) -> UIViewController {
        let businessModel = HomeBusinessModel(repository: HomeAPI(httpClient: httpClient), analytics: analytics)
        let factory = HomeViewControllerFactory(businessModel: businessModel, analytics: homeAnalytics ?? businessModel)
        let mainFlow = HomeFlow(factory: factory, deeplink: Deeplink(screen: HomeDeeplink(rawValue: deeplink?.path ?? "/"), url: deeplink))
        mainFlow.baseFlowDelegate = baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start(useCase: businessModel, analytics: businessModel)
    }
}

enum HomeDeeplink: String, CaseIterable {
    case index = "/"
}
