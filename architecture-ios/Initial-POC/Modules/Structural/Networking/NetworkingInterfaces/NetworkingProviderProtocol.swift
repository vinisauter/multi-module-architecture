//
//  NetworkingProviderProtocol.swift
//  NetworkingInterfaces
//
//  Created by Felippe Matos on 09/12/21.
//

import Foundation

public enum NetworkType {
    case secure
    case someLib
}

public protocol NetworkingProviderProtocol {
    func getHTTPClient(_ type: NetworkType) -> HTTPClient
}
