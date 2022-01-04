//
//  ChipAPI.swift
//  ChipFramework
//
//  Created by Avanade on 22/12/21.
//

import Foundation
import NetworkingInterfaces

class ChipAPI: ChipRepositoryProtocol {
    private let secureHttpClient: HTTPClientProtocol
    
    init(secureHttpClient: HTTPClientProtocol) {
        self.secureHttpClient = secureHttpClient
    }
}
