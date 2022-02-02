//
//  NetworkingDependency.swift
//  NoteDemo
//
//  Created by Ailton Vieira Pinto Filho on 02/02/22.
//

import Foundation
import Networking
import AppSecurityInterfaces

class NetworkingDependency: NetworkingDependencyProtocol {
    private weak var security: AppSecurityProviderProtocol?
    
    init(security: AppSecurityProviderProtocol) {
        self.security = security
    }
    
    func getCertificate(with publicKey: String) -> String {
        return security?.getCertificate(with: publicKey) ?? ""
    }
}
