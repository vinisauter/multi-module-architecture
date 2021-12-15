//
//  NSecurityProvider.swift
//  NSecurity
//
//  Created by Felippe Matos on 14/12/21.
//

import Foundation
import NSecurityInterfaces

open class NSecurityProvider: CertificateProtocol {
    public init() {}
    
    public func getCertificate(by environment: EnvironmentType) -> String {
        switch environment {
        case .debug:
            return DebugCertificate().certificate
            
        case .homologation:
            return HomologationCertificate().certificate
            
        case .production:
            return ProductionCertificate().certificate
            
        }
    }
}
