//
//  AppSecurityProvider.swift
//  AppSecurityInterfaces
//
//  Created by Nykolas Mayko Maia Barbosa on 14/12/21.
//

import Foundation

public protocol AppSecurityProviderProtocol: AnyObject {
    func getCertificate(with publicKey: String) -> String
}
