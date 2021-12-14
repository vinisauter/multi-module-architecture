//
//  HomeAPI.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Foundation
import NetworkingInterfaces

class HomeAPI: HomeRepositoryProtocol {
    private let network: NetworkingProviderProtocol
    
    init(network: NetworkingProviderProtocol) {
        self.network = network
    }
}
