//
//  StructuralDependencyProvider.swift
//  ProfileDemo
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import NetworkingInterfaces
import Networking
import AnalyticsInterfaces
import Analytics

class StructuralDependencyProvider {
    static let shared: StructuralDependencyProvider = StructuralDependencyProvider()
    
    private init() {}
    
    lazy var networking: HTTPClientProtocol = {
        return NetworkingProvider()
    }()
    
    lazy var analytics: AnalyticsProtocol = {
        return Analytics()
    }()
}
