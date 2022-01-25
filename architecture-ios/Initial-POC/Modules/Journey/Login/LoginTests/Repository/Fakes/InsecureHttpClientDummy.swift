//
//  InsecureHttpClientDummy.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import Foundation
import NetworkingInterfaces

class InsecureHttpClientDummy: HTTPClientProtocol {
    func get(_ url: String, completion: @escaping (String) -> Void) {
        
    }
    
    func post(_ url: String, completion: @escaping (String) -> Void) {
        
    }
    
    func put(_ url: String, completion: @escaping (String) -> Void) {
    
    }
    
    func delete(_ url: String, completion: @escaping (String) -> Void) {
        
    }
    
}
