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
    let structuralDependencies: LoginStructuralDependencies
    var customLoginAnalytics: LoginAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ baseFlowDelegate: BaseFlowDelegate?, _ structuralDependencies: LoginStructuralDependencies, _ customLoginAnalytics: LoginAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.baseFlowDelegate = baseFlowDelegate
        self.structuralDependencies = structuralDependencies
        self.customLoginAnalytics = customLoginAnalytics
        self.value = value
    }
}

public protocol LoginStructuralDependencies {
    var networking: Networking { get }
    var analytics: AnalyticsProtocol { get }
}

public class LoginLauncher {
    static public func start(with dependencies: LoginDependencies) -> UIViewController {
        let businessModel = LoginBusinessModel(repository: LoginAPI(httpClient: dependencies.structuralDependencies.networking.getHttpClient()), structuralAnalytics: dependencies.structuralDependencies.analytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customLoginAnalytics)
        let mainFlow = LoginFlow(factory: factory, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.baseFlowDelegate = dependencies.baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
    
    static public func startForgotPassword(with dependencies: LoginDependencies) -> UIViewController {
        let businessModel = LoginBusinessModel(repository: LoginAPI(httpClient: dependencies.structuralDependencies.networking.getHttpClient()), structuralAnalytics: dependencies.structuralDependencies.analytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customLoginAnalytics)
        let mainFlow = ForgotPasswordFlow(factory: factory, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.baseFlowDelegate = dependencies.baseFlowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

// MARK: - Deeplink

enum LoginDeeplink: String, CaseIterable {
    case index = "/"
    case forgotPassword = "/forgotPassword"
}
