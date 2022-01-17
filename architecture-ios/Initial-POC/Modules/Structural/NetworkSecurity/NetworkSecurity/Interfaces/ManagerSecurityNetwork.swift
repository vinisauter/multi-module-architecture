//
//  ManagerSecurityNetwork.swift
//  NetworkSecurity
//
//  Created by ACT on 17/12/21.
//

import Foundation

public protocol ManagerSecurityNetwork{
    func setToken(token: String)
    func getToken() -> String
    func encrypton()
    func decode() -> Data
}
