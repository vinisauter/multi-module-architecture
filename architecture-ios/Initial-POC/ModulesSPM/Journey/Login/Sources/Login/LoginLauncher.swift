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
    var flowDelegate: LoginFlowDelegate?
    let structuralDependencies: LoginStructuralDependencies
    var customLoginAnalytics: LoginAnalyticsProtocol?
    var value: Any?
    
    public init (_ deeplink: URL?, _ flowDelegate: LoginFlowDelegate?, _ structuralDependencies: LoginStructuralDependencies, _ customLoginAnalytics: LoginAnalyticsProtocol?, _ value: Any?) {
        self.deeplink = deeplink
        self.flowDelegate = flowDelegate
        self.structuralDependencies = structuralDependencies
        self.customLoginAnalytics = customLoginAnalytics
        self.value = value
    }
}

public protocol LoginStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
}

public class LoginLauncher {
    static public func start(with dependencies: LoginDependencies) -> UIViewController {
        let loginAPI = LoginAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient(), insecureHttpClient: dependencies.structuralDependencies.networkingProvider.getInsecureHttpClient())
        let businessModel = LoginBusinessModel(repository: loginAPI, structuralAnalytics: dependencies.structuralDependencies.analytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customLoginAnalytics)
        let mainFlow = LoginFlow(factory: factory, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.delegate = dependencies.flowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
    
    static public func startForgotPassword(with dependencies: LoginDependencies) -> UIViewController {
        let loginAPI = LoginAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient(), insecureHttpClient: dependencies.structuralDependencies.networkingProvider.getInsecureHttpClient())
        let businessModel = LoginBusinessModel(repository: loginAPI, structuralAnalytics: dependencies.structuralDependencies.analytics)
        let factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customLoginAnalytics)
        let mainFlow = ForgotPasswordFlow(factory: factory, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.delegate = dependencies.flowDelegate
        factory.flow = mainFlow
        
        return mainFlow.start()
    }
}

// MARK: - Deeplink

enum LoginDeeplink: String, CaseIterable {
    case index = "/"
    case forgotPassword = "/forgotPassword"
}

public enum Flow: CaseIterable {
    case main
    case forgotPassword
}
