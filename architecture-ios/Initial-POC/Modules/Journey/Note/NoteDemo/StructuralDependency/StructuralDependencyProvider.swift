//
//  StructuralDependencyProvider.swift
//  NoteDemo
//
//  Created by Ailton Vieira Pinto Filho on 02/02/22.
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
