//
//  LibTwoHTTPClient.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 03/12/21.
//

import NetworkingInterfaces

public final class LibTwoHTTPClient: HTTPClientProtocol {
    public func get(_ url: String, certificate: String, completion: @escaping (String) -> Void) {
        execute(url, certificate: certificate, method: "GET", completion: completion)
    }

    public func post(_ url: String, certificate: String, completion: @escaping (String) -> Void) {
        execute(url, certificate: certificate, method: "POST", completion: completion)
    }

    public func put(_ url: String, certificate: String, completion: @escaping (String) -> Void) {
        execute(url, certificate: certificate, method: "PUT", completion: completion)
    }

    public func delete(_ url: String, certificate: String, completion: @escaping (String) -> Void) {
        execute(url, certificate: certificate, method: "DELETE", completion: completion)
    }
    
    private func execute(_ url: String, certificate: String, method: String, completion: @escaping (String) -> Void) {
        debugPrint("======= Using SecureLib to do HTTP \(method) Calls witch certificate \(certificate)")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(method)
        }
    }
}
