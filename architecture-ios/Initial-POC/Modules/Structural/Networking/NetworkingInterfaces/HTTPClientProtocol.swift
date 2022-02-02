//
//  HTTPClient.swift
//  NetworkingInterfaces
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation

public protocol HTTPClientProtocol {
    func get(_ url: String, completion: @escaping (String) -> Void)
    func post(_ request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void)
    func put(_ url: String, completion: @escaping (String) -> Void)
    func delete(_ url: String, completion: @escaping (String) -> Void)
}

public enum NetworkError: Error, Equatable {
    case error
}
