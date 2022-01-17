//
//  HTTPClient.swift
//  NetworkingInterfaces
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkSecurity

public protocol HTTPClientProtocol {
    
    init(security:ManagerSecurityNetwork)
    func getManagerSecurity() -> ManagerSecurityNetwork
    
    func get(_ url: String, completion: @escaping (String) -> Void)
    func post(_ url: String, completion: @escaping (String) -> Void)
    func put(_ url: String, completion: @escaping (String) -> Void)
    func delete(_ url: String, completion: @escaping (String) -> Void)
}
