//
//  HomeIndexFlowDelegate.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 01/12/21.
//

import Foundation

public protocol HomeIndexFlowDelegate: AnyObject {
    func openProfile(in controller: HomeIndexViewController)
    func logout(in controller: HomeIndexViewController)
}
