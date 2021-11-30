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
    static var networking: Networking = {
        return Networking()
    }()
    
    static var analytics: AnalyticsProtocol = {
        return Analytics()
    }()
}
