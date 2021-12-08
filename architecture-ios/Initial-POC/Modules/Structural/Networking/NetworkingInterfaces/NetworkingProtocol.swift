//
//  NetworkingProtocol.swift
//  NetworkingInterfaces
//
//  Created by Nykolas Mayko Maia Barbosa on 08/12/21.
//

import Foundation

public protocol NetworkingProtocol {
    func getHttpClient() -> HTTPClientProtocol
}
