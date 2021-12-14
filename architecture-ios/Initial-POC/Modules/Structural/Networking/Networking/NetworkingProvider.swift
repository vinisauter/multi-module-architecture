//
//  NetworkingProvider.swift
//  Networking
//
//  Created by Felippe Matos on 09/12/21.
//

import Foundation
import NetworkingInterfaces

public class NetworkingProvider: NetworkingProviderProtocol {
    public init() {}
    
    public func getHTTPClient(_ type: NetworkType) -> HTTPClient {
        switch type {
        case .secure:
            return SecureNetwork()
        case .someLib:
            return SomeLibNetwork()
        }
    }
}
