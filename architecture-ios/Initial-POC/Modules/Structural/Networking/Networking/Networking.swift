//
//  Networking.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingInterfaces

open class Networking: HTTPClient {
    
    public init() {}
    
    public func get() -> String {
        return "GET"
    }
    
    public func post() -> String {
        return "POST"
    }
    
    public func put() -> String {
        return "PUT"
    }
    
    public func delete() -> String {
        return "DELETE"
    }
}
