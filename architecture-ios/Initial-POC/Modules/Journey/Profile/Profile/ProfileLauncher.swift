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
    var baseFlowDelegate: BaseFlowDelegate?
    var baseFlowDataSource: BaseFlowDataSource?
    let networking: HTTPClient
    let structuralAnalytics: AnalyticsProtocol
    var customProfileAnalytics: ProfileAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ baseFlowDelegate: BaseFlowDelegate?, _ baseFlowDataSource: BaseFlowDataSource?, _ networking: HTTPClient, _ structuralAnalytics: AnalyticsProtocol, _ customProfileAnalytics: ProfileAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.baseFlowDelegate = baseFlowDelegate
        self.baseFlowDataSource = baseFlowDataSource
        self.networking = networking
        self.structuralAnalytics = structuralAnalytics
        self.customProfileAnalytics = customProfileAnalytics
        self.value = value
    }
}


public class ProfileLauncher {
    static public func start(with dependencies: ProfileDependencies) -> UIViewController {
        let businessModel = ProfileBusinessModel(repository: ProfileAPI(httpClient: dependencies.networking), structuralAnalytics: dependencies.structuralAnalytics)
        let factory = ProfileViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customProfileAnalytics)
        let mainFlow = ProfileFlow(factory: factory, deeplink: Deeplink(value: ProfileDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.baseFlowDelegate = dependencies.baseFlowDelegate
        mainFlow.baseFlowDataSource = dependencies.baseFlowDataSource
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

enum ProfileDeeplink: String, CaseIterable {
    case index = "/"
    case forgotPassword = "/forgotPassword"
}
