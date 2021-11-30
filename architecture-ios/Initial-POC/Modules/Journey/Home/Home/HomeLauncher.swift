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

public struct HomeDependencies {
    var deeplink: URL?
    var baseFlowDelegate: BaseFlowDelegate?
    let networking: HTTPClient
    let structuralAnalytics: AnalyticsProtocol
    var customHomeAnalytics: HomeAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ baseFlowDelegate: BaseFlowDelegate?, _ networking: HTTPClient, _ structuralAnalytics: AnalyticsProtocol, _ customHomeAnalytics: HomeAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.baseFlowDelegate = baseFlowDelegate
        self.networking = networking
        self.structuralAnalytics = structuralAnalytics
        self.customHomeAnalytics = customHomeAnalytics
        self.value = value
    }
}

public class HomeLauncher {
    static public func start(with dependencies: HomeDependencies) -> UIViewController {
        let businessModel = HomeBusinessModel(repository: HomeAPI(httpClient: dependencies.networking), structuralAnalytics: dependencies.structuralAnalytics)
        let factory = HomeViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customHomeAnalytics)
        let mainFlow = HomeFlow(factory: factory, deeplink: Deeplink(value: HomeDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.baseFlowDelegate = dependencies.baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start(useCase: businessModel, analytics: businessModel)
    }
}

enum HomeDeeplink: String, CaseIterable {
    case index = "/"
}
