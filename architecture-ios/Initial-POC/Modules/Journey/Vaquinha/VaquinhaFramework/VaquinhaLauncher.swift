//
//  VaquinhaLauncher.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core
import NetworkingInterfaces
import AnalyticsInterfaces

public struct VaquinhaDependencies {
    var deeplink: URL?
    var flowDelegate: VaquinhaFlowDelegate?
    let structuralDependencies: VaquinhaStructuralDependencies
    var customVaquinhaAnalytics: VaquinhaStructuralAnalyticsProtocol?
    var value: Any?
    
    public init(deeplink: URL?, flowDelegate: VaquinhaFlowDelegate, structuralDependencies: VaquinhaStructuralDependencies, customVaquinhaAnalytics: VaquinhaStructuralAnalyticsProtocol?,
                value: Any?) {
        self.deeplink = deeplink
        self.flowDelegate = flowDelegate
        self.structuralDependencies = structuralDependencies
        self.customVaquinhaAnalytics = customVaquinhaAnalytics
    }
}

public protocol VaquinhaStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
}

public class VaquinhaLauncher {
    static public func start(with dependencies: VaquinhaDependencies) -> UIViewController {
        let vaquinhaAPI = VaquinhaAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient())
        
        let businessModel = VaquinhaBusinessModel(repository: vaquinhaAPI, structuralAnalytics: dependencies.structuralDependencies.analytics)
        
        let factory = VaquinhaViewControllerFactory(businessModel: businessModel, analytics: dependencies.customVaquinhaAnalytics)
        
        let deepLink = Deeplink(value: VaquinhaDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink)
        
        let mainFlow = VaquinhaFlow(factory: factory, deeplink: deepLink)
        
        mainFlow.delegate = dependencies.flowDelegate
        
        return mainFlow.start()
    }
}


// MARK: - Deeplink

enum VaquinhaDeeplink: String, CaseIterable {
    case home = "/"
}

// MARK: - Flow

public enum Flow: CaseIterable {
    case main
}
