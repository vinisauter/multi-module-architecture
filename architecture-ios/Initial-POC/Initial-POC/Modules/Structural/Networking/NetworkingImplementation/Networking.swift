//
//  Networking.swift
//  NetworkingImplementation
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingProtocol

class Networking: HTTPClient {
    func get() -> String {
        return "GET"
    }
    
    func post() -> String {
        return "POST"
    }
    
    func put() -> String {
        return "PUT"
    }
    
    func delete() -> String {
        return "DELETE"
    }
}
