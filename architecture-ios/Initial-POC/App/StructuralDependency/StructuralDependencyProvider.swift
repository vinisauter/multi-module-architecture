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

class StructuralDependencyProvider {
    static let shared: StructuralDependencyProvider = StructuralDependencyProvider()
    
    private init() {}
    
    lazy var networking: NetworkingInterfaces.Networking = {
        return Networking()
    }()
    
    lazy var analytics: AnalyticsProtocol = {
        return Analytics()
    }()
}
