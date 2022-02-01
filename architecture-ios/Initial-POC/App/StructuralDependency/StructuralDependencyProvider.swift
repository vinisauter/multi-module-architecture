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

public class StructuralDependencyProvider {
    public static let shared: StructuralDependencyProvider = StructuralDependencyProvider()
    
    private init() {}
    
    lazy public var networkingProvider: NetworkingProviderProtocol = {
        return NetworkingProvider()
    }()
    
    lazy public var analytics: AnalyticsProtocol = {
        return Analytics()
    }()
}
