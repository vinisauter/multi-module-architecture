//
//  Networking.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingInterfaces
import Core
import NetworkSecurity

// Networking Inject Providers
protocol NetworkingInjectProvidersProtocol {
    func getNetworkSecurity() -> NetworkSecurityProviderProtocol
}

open class NetworkingProvider: InjectProviders, NetworkingInjectProvidersProtocol, NetworkingProviderProtocol, BaseProvider{
    
    public typealias TypeOfProvider = NetworkingProvider.Type
    public var provider: TypeOfProvider
    
    public required init(typeProvider: TypeOfProvider) {
        self.provider = typeProvider
    }
    
    // get Provider Network Security
    func getNetworkSecurity() -> NetworkSecurityProviderProtocol{
        return get(name: "security", to: NetworkSecurityProviderProtocol.self)
    }
    
    public func getSecureHttpClient() -> HTTPClientProtocol {
        return LibOneHTTPClient(security: getNetworkSecurity().getNetworkSecurity())
    }
    
    public func getInsecureHttpClient() -> HTTPClientProtocol {
        return LibTwoHTTPClient(security: getNetworkSecurity().getNetworkSecurity())
    }
    
}
