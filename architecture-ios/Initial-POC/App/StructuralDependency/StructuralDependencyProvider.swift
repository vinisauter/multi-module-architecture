//
//  DependencyProvider.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import NetworkingInterfaces
import Networking
import AnalyticsInterfaces
import Analytics
import AppSecurityInterfaces
import AppSecurity
import FlutterManagerInterfaces
import FlutterManager

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
    
    lazy var flutterManager: FlutterManagerProtocol = {
        return FlutterManager()
    }()
}
