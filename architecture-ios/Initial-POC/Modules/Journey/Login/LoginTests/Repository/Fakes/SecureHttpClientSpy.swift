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
    
    func get(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func post(_ url: String, completion: @escaping (String) -> Void) {
        urls.append(url)
        
        completion("Passed")
    }
    
    func put(_ url: String, completion: @escaping (String) -> Void) {
    }
    
    func delete(_ url: String, completion: @escaping (String) -> Void) {
    }
    
}
