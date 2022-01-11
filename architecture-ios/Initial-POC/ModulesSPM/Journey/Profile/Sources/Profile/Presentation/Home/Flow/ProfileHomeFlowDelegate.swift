//
//  ProfileHomeFlowDelegate.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 01/12/21.
//

import Foundation

public protocol ProfileHomeFlowDelegate: AnyObject {
    func goToHome(in controller: ProfileHomeViewController)
    func callLogin(in controller: ProfileHomeViewController)
    func goToForgotPassword(in controller: ProfileHomeViewController)
}
