//
//  NetworkSecurityProvider.swift
//  NetworkSecurity
//
//  Created by ACT on 17/12/21.
//

import Foundation
import Core

open class NetworkSecurityProvider: InjectProviders, NetworkSecurityProviderProtocol, BaseProvider{
    
    public typealias TypeOfProvider = NetworkSecurityProvider.Type
    public var provider: TypeOfProvider
    
    public required init(typeProvider: TypeOfProvider) {
        self.provider = typeProvider
    }
    
    public func getNetworkSecurity() -> ManagerSecurityNetwork {
        return OneManagerSecurityNetwork()
    }
    
}
