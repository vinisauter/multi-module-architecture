//
//  LibOneHTTPClient.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 03/12/21.
//

import NetworkingInterfaces

public final class LibOneHTTPClient: HTTPClientProtocol {
    public func get(completion: @escaping (String) -> Void) {
        execute("GET", completion: completion)
    }

    public func post(completion: @escaping (String) -> Void) {
        execute("POST", completion: completion)
    }

    public func put(completion: @escaping (String) -> Void) {
        execute("PUT", completion: completion)
    }

    public func delete(completion: @escaping (String) -> Void) {
        execute("DELETE", completion: completion)
    }
    
    private func execute(_ method: String, completion: @escaping (String) -> Void) {
        debugPrint("======= Using Lib1 to do HTTP \(method) Calls")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(method)
        }
    }
}


