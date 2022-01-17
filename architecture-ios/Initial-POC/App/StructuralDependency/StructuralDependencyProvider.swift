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

import NetworkSecurity

class StructuralDependencyProvider {
    
    static let shared: StructuralDependencyProvider = StructuralDependencyProvider()
    
    private init() {}
    
    lazy var networkingProvider: NetworkingProviderProtocol = {
        NetworkingProvider.addProvider(name: "security", ob: self.networkSecurityProvider as AnyObject)
        NetworkingProvider.addProvider(name: "analytics", ob: self.analytics as AnyObject)
        return NetworkingProvider(typeProvider: NetworkingProvider.self)
    }()
    
    lazy var analytics: AnalyticsProtocol = {
        return Analytics()
    }()
    
    lazy var networkSecurityProvider: NetworkSecurityProviderProtocol = {
        return NetworkSecurityProvider(typeProvider: NetworkSecurityProvider.self)
    }()
}
