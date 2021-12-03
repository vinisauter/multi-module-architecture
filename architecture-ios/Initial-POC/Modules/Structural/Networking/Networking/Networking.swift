//
//  Networking.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingInterfaces

open class Networking: NetworkingInterfaces.Networking {
    
    public init() {}
    
    public func getHttpClient() -> HTTPClient {
        let isLibOne = Bool.random()
        if isLibOne {
            return LibOneHTTPClient()
        } else {
            return LibTwoHTTPClient()
        }
    }
}
