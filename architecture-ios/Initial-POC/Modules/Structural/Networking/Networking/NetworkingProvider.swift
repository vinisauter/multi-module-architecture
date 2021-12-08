//
//  Networking.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingInterfaces

open class NetworkingProvider: NetworkingProviderProtocol {
    
    public init() {}
    
    public func getSecureHttpClient() -> HTTPClientProtocol {
        return LibOneHTTPClient()
    }
    
    public func getInsecureHttpClient() -> HTTPClientProtocol {
        return LibTwoHTTPClient()
    }
}
