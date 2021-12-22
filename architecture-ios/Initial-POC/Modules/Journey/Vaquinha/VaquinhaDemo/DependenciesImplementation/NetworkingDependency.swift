//
//  NetworkDependency.swift
//  Vaquinha
//
//  Created by Avanade on 22/12/21.
//

import Foundation
import Networking
import AppSecurityInterfaces

class NetworkingDependency: NetworkingDependencyProtocol {
    private weak var security: AppSecurityProviderProtocol?

    init(security: AppSecurityProviderProtocol){
        self.security = security
    }
    
    func getCertificate(with publicKey: String) -> String {
        return security?.getCertificate(with: publicKey) ?? ""
    }
}
