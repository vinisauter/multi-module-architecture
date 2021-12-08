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
    let structuralDependencies: HomeStructuralDependencies
    var customHomeAnalytics: HomeAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ baseFlowDelegate: BaseFlowDelegate?, _ structuralDependencies: HomeStructuralDependencies, _ customHomeAnalytics: HomeAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.baseFlowDelegate = baseFlowDelegate
        self.structuralDependencies = structuralDependencies
        self.customHomeAnalytics = customHomeAnalytics
        self.value = value
    }
}

public protocol HomeStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
}

public class HomeLauncher {
    static public func start(with dependencies: HomeDependencies) -> UIViewController {
        let homeAPI = HomeAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient())
        let businessModel = HomeBusinessModel(repository: homeAPI, structuralAnalytics: dependencies.structuralDependencies.analytics)
        let factory = HomeViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customHomeAnalytics)
        let mainFlow = HomeFlow(factory: factory, deeplink: Deeplink(value: HomeDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.baseFlowDelegate = dependencies.baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

// MARK: - Deeplink

enum HomeDeeplink: String, CaseIterable {
    case index = "/"
}
