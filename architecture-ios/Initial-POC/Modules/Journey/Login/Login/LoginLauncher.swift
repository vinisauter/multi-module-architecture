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

public struct LoginDependencies {
    var deeplink: URL?
    var baseFlowDelegate: BaseFlowDelegate?
    let networking: HTTPClient
    let structuralAnalytics: AnalyticsProtocol
    var customLoginAnalytics: LoginAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ baseFlowDelegate: BaseFlowDelegate?, _ networking: HTTPClient, _ structuralAnalytics: AnalyticsProtocol, _ customLoginAnalytics: LoginAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.baseFlowDelegate = baseFlowDelegate
        self.networking = networking
        self.structuralAnalytics = structuralAnalytics
        self.customLoginAnalytics = customLoginAnalytics
        self.value = value
    }
}


public class LoginLauncher {
    static public func start(with dependenies: LoginDependencies) -> UIViewController {
        let businessModel = LoginBusinessModel(repository: LoginAPI(httpClient: dependenies.networking), structuralAnalytics: dependenies.structuralAnalytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependenies.customLoginAnalytics)
        let mainFlow = LoginFlow(factory: factory, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependenies.deeplink?.path ?? "/"), url: dependenies.deeplink))
        mainFlow.baseFlowDelegate = dependenies.baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
    
    static public func startForgotPassword(with dependenies: LoginDependencies) -> UIViewController {
        let businessModel = LoginBusinessModel(repository: LoginAPI(httpClient: dependenies.networking), structuralAnalytics: dependenies.structuralAnalytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependenies.customLoginAnalytics)
        let mainFlow = ForgotPasswordFlow(factory: factory, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependenies.deeplink?.path ?? "/"), url: dependenies.deeplink))
        mainFlow.baseFlowDelegate = dependenies.baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

enum LoginDeeplink: String, CaseIterable {
    case index = "/"
    case forgotPassword = "/forgotPassword"
}
