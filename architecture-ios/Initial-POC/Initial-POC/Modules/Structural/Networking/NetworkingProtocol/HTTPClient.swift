//
//  HTTPClient.swift
//  NetworkingProtocol
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation

public protocol HTTPClient {
    func get() -> String
    func post() -> String
    func put() -> String
    func delete() -> String
}
