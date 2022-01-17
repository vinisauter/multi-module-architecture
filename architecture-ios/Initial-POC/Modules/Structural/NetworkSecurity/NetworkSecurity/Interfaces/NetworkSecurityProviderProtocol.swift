//
//  NetworkSecurityProcotocol.swift
//  NetworkSecurity
//
//  Created by ACT on 17/12/21.
//

import Foundation

public protocol NetworkSecurityProviderProtocol{
    func getNetworkSecurity() -> ManagerSecurityNetwork
}
