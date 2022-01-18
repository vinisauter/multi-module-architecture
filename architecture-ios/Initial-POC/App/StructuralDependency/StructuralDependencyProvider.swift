//
//  DependencyProvider.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import NetworkingInterfaces
import Networking
import AnalyticsInterfaces
import AppSecurityInterfaces
import AppSecurity

class StructuralDependencyProvider {
    static let shared: StructuralDependencyProvider = StructuralDependencyProvider()
    
    private init() {}
    
    lazy var networkingProvider: NetworkingProviderProtocol = {
        return NetworkingProvider(networkingDependency: NetworkingDependency(security: security))
    }()
    
    lazy var analytics: AnalyticsProtocol = {
        return Analytics()
    }()
    
    lazy var security: AppSecurityProviderProtocol = {
        return AppSecurityProvider()
    }()
}
