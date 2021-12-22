//
//  VaquinhaAPI.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import Foundation
import NetworkingInterfaces

class VaquinhaAPI: VaquinhaRepositoryProtocol {
    private let secureHttpClient: HTTPClientProtocol
    
    init(secureHttpClient: HTTPClientProtocol) {
        self.secureHttpClient = secureHttpClient
    }
}
