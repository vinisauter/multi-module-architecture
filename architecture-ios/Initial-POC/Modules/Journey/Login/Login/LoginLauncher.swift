//
//  LoginLauncher.swift
//  Login
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import NetworkingInterfaces
import AnalyticsInterfaces
import Core

public class LoginLauncher {
    static public func start(from deeplink: URL?, baseFlowDelegate: BaseFlowDelegate?, httpClient: HTTPClient, analytics: AnalyticsProtocol, loginAnalytics: LoginAnalyticsProtocol?) -> UIViewController {
        let businessModel = LoginBusinessModel(repository: LoginAPI(httpClient: httpClient), analytics: analytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, analytics: loginAnalytics ?? businessModel)
        let mainFlow = LoginFlow(factory: factory, deeplink: Deeplink(screen: LoginDeeplink(rawValue: deeplink?.path ?? "/"), url: deeplink))
        mainFlow.baseFlowDelegate = baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

enum LoginDeeplink: String, CaseIterable {
    case index = "/"
    case forgotPassword = "/forgotPassword"
}
