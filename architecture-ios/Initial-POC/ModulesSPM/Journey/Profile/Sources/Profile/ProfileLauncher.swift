//
//  ProfileLauncher.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core
import NetworkingInterfaces
import AnalyticsInterfaces

public struct ProfileDependencies {
    var deeplink: URL?
    var flowDelegate: ProfileFlowDelegate?
    var flowDataSource: ProfileFlowDataSource?
    let structuralDependencies: ProfileStructuralDependencies
    var customProfileAnalytics: ProfileAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ flowDelegate: ProfileFlowDelegate?, _ flowDataSource: ProfileFlowDataSource?, _ structuralDependencies: ProfileStructuralDependencies, _ customProfileAnalytics: ProfileAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.flowDelegate = flowDelegate
        self.flowDataSource = flowDataSource
        self.structuralDependencies = structuralDependencies
        self.customProfileAnalytics = customProfileAnalytics
        self.value = value
    }
}

public protocol ProfileStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
}

public class ProfileLauncher {
    static public func start(with dependencies: ProfileDependencies) -> UIViewController {
        let profileAPI = ProfileAPI(httpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient())
        let businessModel = ProfileBusinessModel(repository: profileAPI, structuralAnalytics: dependencies.structuralDependencies.analytics)
        let factory = ProfileViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customProfileAnalytics)
        let mainFlow = ProfileFlow(factory: factory, deeplink: Deeplink(value: ProfileDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.delegate = dependencies.flowDelegate
        mainFlow.dataSource = dependencies.flowDataSource
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

// MARK: - Deeplink

enum ProfileDeeplink: String, CaseIterable {
    case index = "/"
    case forgotPassword = "/forgotPassword"
}

// MARK: - Flow

public enum Flow: CaseIterable {
    case main
    case forgotPassword
}
