//
//  InsecureHttpClientDummy.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import Foundation
import NetworkingInterfaces

class InsecureHttpClientFake: HTTPClientProtocol {
    var urls = [String]()
    var requestValue = [String]()
    var result = ""
    
    func get(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func post(_ request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void) {
        urls.append(request.url?.absoluteString ?? "")
        requestValue.append(request.value(forHTTPHeaderField: "Authorization") ?? "")
        
        if result == "error" {
            completion(.failure(.error))
        } else {
            completion(.success(result))
        }
    }
    
    func put(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func delete(_ url: String, completion: @escaping (String) -> Void) {
    }
    
}
