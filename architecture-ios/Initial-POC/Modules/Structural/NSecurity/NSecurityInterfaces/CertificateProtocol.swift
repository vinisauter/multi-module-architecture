//
//  CertificateProtocol.swift
//  NSecurityInterfaces
//
//  Created by Felippe Matos on 14/12/21.
//

import Foundation

public enum EnvironmentType {
    case debug
    case homologation
    case production
}

public protocol CertificateProtocol {
    func getCertificate(by environment: EnvironmentType) -> String
}
