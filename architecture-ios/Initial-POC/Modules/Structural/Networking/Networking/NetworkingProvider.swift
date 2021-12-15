//
//  Networking.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingInterfaces

public protocol NetworkingDependencyProtocol {
    func getCertificate() -> String
}

open class NetworkingProvider: NetworkingProviderProtocol {
    
    private var networkingDependency: NetworkingDependencyProtocol
    
    public init(networkingDependency: NetworkingDependencyProtocol) {
        self.networkingDependency = networkingDependency
    }
    
    public func getSecureHttpClient() -> HTTPClientProtocol {
        return LibOneHTTPClient(certificate: networkingDependency.getCertificate())
    }
    
    public func getInsecureHttpClient() -> HTTPClientProtocol {
        return LibTwoHTTPClient()
    }
}
