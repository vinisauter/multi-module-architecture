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

public class ProfileLauncher {
    static public func start(from deeplink: URL?, baseFlowDelegate: BaseFlowDelegate?, baseFlowDataSource: BaseFlowDataSource?, httpClient: HTTPClient, analytics: AnalyticsProtocol, customProfileAnalytics: ProfileAnalyticsProtocol?) -> UIViewController {
        let businessModel = ProfileBusinessModel(repository: ProfileAPI(httpClient: httpClient), analytics: analytics)
        let factory = ProfileViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: customProfileAnalytics)
        let mainFlow = ProfileFlow(factory: factory, deeplink: Deeplink(screen: ProfileDeeplink(rawValue: deeplink?.path ?? "/"), url: deeplink))
        mainFlow.baseFlowDelegate = baseFlowDelegate
        mainFlow.baseFlowDataSource = baseFlowDataSource
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

enum ProfileDeeplink: String, CaseIterable {
    case index = "/"
}
