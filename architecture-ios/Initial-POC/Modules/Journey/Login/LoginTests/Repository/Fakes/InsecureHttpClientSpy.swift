//
//  InsecureHttpClientDummy.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import Foundation
import NetworkingInterfaces

class InsecureHttpClientSpy: HTTPClientProtocol {
    func get(_ url: String, completion: @escaping (String) -> Void) {
        completion("")
    }
    
    func post(_ request: URLRequest, completion: @escaping (String) -> Void) {
        completion("")
    }
    
    func put(_ url: String, completion: @escaping (String) -> Void) {
        completion("")
    }
    
    func delete(_ url: String, completion: @escaping (String) -> Void) {
        completion("")
    }
    
}
