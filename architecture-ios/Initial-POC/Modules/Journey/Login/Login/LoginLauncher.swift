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
    private var loginAPI: LoginRepositoryProtocol?
    private var businessModel: LoginBusinessModel?
    private var factory: LoginViewControllerFactory?
    private var flow: LoginFlowProtocol?
    
    public init() {}
    
    public func start(with dependencies: LoginDependencies) -> UIViewController {
        loginAPI = LoginAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient(), insecureHttpClient: dependencies.structuralDependencies.networkingProvider.getInsecureHttpClient())
        businessModel = LoginBusinessModel(repository: loginAPI!, structuralAnalytics: dependencies.structuralDependencies.analytics)
        factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customLoginAnalytics)
        flow = LoginFlow(factory: factory!, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        flow!.delegate = dependencies.flowDelegate
        factory!.flow = flow!
        
        return flow!.start()
    }
    
    public func startForgotPassword(with dependencies: LoginDependencies) -> UIViewController {
        loginAPI = LoginAPI(secureHttpClient: dependencies.structuralDependencies.networkingProvider.getSecureHttpClient(), insecureHttpClient: dependencies.structuralDependencies.networkingProvider.getInsecureHttpClient())
        businessModel = LoginBusinessModel(repository: loginAPI!, structuralAnalytics: dependencies.structuralDependencies.analytics)
        factory = LoginViewControllerFactory(businessModel: businessModel, defaultAnalytics: businessModel, customAnalytics: dependencies.customLoginAnalytics)
        flow = ForgotPasswordFlow(factory: factory!, deeplink: Deeplink(value: LoginDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        flow!.delegate = dependencies.flowDelegate
        factory!.flow = flow!
        
        return flow!.start()
    }
    
    public func dispose() {
        loginAPI = nil
        businessModel = nil
        factory = nil
        flow?.dispose()
        flow = nil
    }
    
    public func handleDeeplink(_ url: URL) {
        let d = Deeplink(value: LoginDeeplink(rawValue: url.path), url: url)
        
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
