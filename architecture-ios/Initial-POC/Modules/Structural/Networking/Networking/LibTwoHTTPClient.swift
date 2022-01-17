//
//  LibTwoHTTPClient.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 03/12/21.
//

import NetworkingInterfaces
import NetworkSecurity

public final class LibTwoHTTPClient: HTTPClientProtocol {
   
    
    private var managerSecurity: ManagerSecurityNetwork
    
    public init(security: ManagerSecurityNetwork) {
        self.managerSecurity = security
    }
    
    public func getManagerSecurity() -> ManagerSecurityNetwork {
        return self.managerSecurity
    }
    
    
    public func get(_ url: String, completion: @escaping (String) -> Void) {
        execute(url, method: "GET", completion: completion)
    }

    public func post(_ url: String, completion: @escaping (String) -> Void) {
        execute(url, method: "POST", completion: completion)
    }

    public func put(_ url: String, completion: @escaping (String) -> Void) {
        execute(url, method: "PUT", completion: completion)
    }

    public func delete(_ url: String, completion: @escaping (String) -> Void) {
        execute(url, method: "DELETE", completion: completion)
    }
    
    private func execute(_ url: String, method: String, completion: @escaping (String) -> Void) {
        debugPrint("======= Using InsecureLib to do HTTP \(method) Calls")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(method)
        }
    }
}
