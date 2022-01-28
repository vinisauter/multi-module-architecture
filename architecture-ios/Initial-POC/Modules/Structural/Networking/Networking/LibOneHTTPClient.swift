//
//  LibOneHTTPClient.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 03/12/21.
//

import NetworkingInterfaces
import NetworkSecurity

public final class LibOneHTTPClient: HTTPClientProtocol {
    
<<<<<<< HEAD
    private var managerSecurirty: ManagerSecurityNetwork
    
    public init(security: ManagerSecurityNetwork) {
        self.managerSecurirty = security
    }
    
    public func getManagerSecurity() -> ManagerSecurityNetwork {
        return self.managerSecurirty
=======
    private var certificate: String
    
    init(certificate: String) {
        self.certificate = certificate
>>>>>>> 8d21c778caa3364768971b256379a0e708797006
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
        debugPrint("======= Using SecureLib to do HTTP \(method) Calls")
        debugPrint(certificate)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(method)
        }
    }
}


