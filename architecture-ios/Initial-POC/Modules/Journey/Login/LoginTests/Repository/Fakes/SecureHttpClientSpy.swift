//
//  SecureHttpClientDummy.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import Foundation
import NetworkingInterfaces
import CoreMedia

class SecureHttpClientSpy: HTTPClientProtocol {
    var urls = [String]()
    var isValidAuthentication = false
    
    func get(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func post(_ request: URLRequest, completion: @escaping (Bool) -> Void) {
        urls.append(request.url?.absoluteString ?? "")
        
        completion(isValidAuthentication)
    }
    
    func put(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func delete(_ url: String, completion: @escaping (String) -> Void) {
    }
    
}
