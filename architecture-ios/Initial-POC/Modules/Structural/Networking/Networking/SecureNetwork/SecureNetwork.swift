//
//  SecureNetwork.swift
//  Networking
//
//  Created by Felippe Matos on 08/12/21.
//

import Foundation
import NetworkingInterfaces

open class SecureNetwork: HTTPClient {
    
    public init() {}
    
    public func get() -> String {
        return "Secure GET"
    }
    
    public func post() -> String {
        return "Secure POST"
    }
    
    public func put() -> String {
        return "Secure PUT"
    }
    
    public func delete() -> String {
        return "Secure DELETE"
    }
}
