//
//  SecureHttpClientDummy.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import Foundation
import NetworkingInterfaces
import CoreMedia

class SecureHttpClientFake: HTTPClientProtocol {
    var urls = [String]()
    var requestValue = [String]()
    var result = ""
    
    func get(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func post(_ request: URLRequest, completion: @escaping (String) -> Void) {
        urls.append(request.url?.absoluteString ?? "")
        requestValue.append(request.value(forHTTPHeaderField: "Authorization") ?? "")
        
        completion(result)
    }
    
    func put(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func delete(_ url: String, completion: @escaping (String) -> Void) {
    }
    
}
