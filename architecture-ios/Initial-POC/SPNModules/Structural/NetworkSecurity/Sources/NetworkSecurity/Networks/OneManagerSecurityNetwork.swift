//
//  OneManagerSercurityNetwork.swift
//  NetworkSecurity
//
//  Created by ACT on 17/12/21.
//

import Foundation
import CryptoKit

public class OneManagerSecurityNetwork: ManagerSecurityNetwork{
    
    public var token: String?
    
    public init(){}
    
    public func setToken(token: String) {
        self.token = token
    }
    
    public func getToken() -> String {
        return "Token Test"
    }
    
    public func encrypton() {
        let hash = String(describing: SHA256.hash(data: "value test".data(using: .utf8)!))
        print("Encryption \(hash)")
    }
    
    public func encode(){
        
    }
    
    public func decode() -> Data {
        return  Data(base64Encoded: token!)!
    }
    
    
}
