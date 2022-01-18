//
//  ChipLauncher.swift
//  ChipFramework
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core
import NetworkingInterfaces
import AnalyticsInterfaces

public struct ChipDependencies {
    var deeplink: URL?
    var flowDelegate: ChipFlowDelegate?
    let structuralDependencies: ChipStructuralDependencies
    var customChipAnalytics: ChipStructuralAnalyticsProtocol?
    var value: Any?
    
    public init(deeplink: URL?, flowDelegate: ChipFlowDelegate, structuralDependencies: ChipStructuralDependencies, customChipAnalytics: ChipStructuralAnalyticsProtocol?,
                value: Any?) {
        self.deeplink = deeplink
        self.flowDelegate = flowDelegate
        self.structuralDependencies = structuralDependencies
        self.customChipAnalytics = customChipAnalytics
    }
}

public protocol ChipStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
}

public class ChipLauncher {
    static public func start(with dependencies: ChipDependencies) -> UIViewController {
        let chipAPI = ChipAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient())
        
        let businessModel = ChipBusinessModel(repository: chipAPI, structuralAnalytics: dependencies.structuralDependencies.analytics)
        
        
        let factory = ChipViewControllerFactory(businessModel: businessModel, analytics: businessModel)
        
        let deepLink = Deeplink(value: ChipDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink)
        
        let mainFlow = ChipFlow(factory: factory, deeplink: deepLink)
        
        mainFlow.delegate = dependencies.flowDelegate
        
        return mainFlow.start()
    }
}


// MARK: - Deeplink

enum ChipDeeplink: String, CaseIterable {
    case home = "/"
}

// MARK: - Flow

public enum Flow: CaseIterable {
    case main
}
