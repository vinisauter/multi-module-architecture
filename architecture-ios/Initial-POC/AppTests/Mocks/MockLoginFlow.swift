//
//  MockLoginFlow.swift
//  AppTests
//
//  Created by ACT on 02/02/22.
//

import Foundation
import Login

class MockLoginFlow: LoginIndexFlowDelegate{
    
    func onLoginSuccess(in controller: LoginIndexViewController) {
        print("on Login Success")
    }
    
    func onForgotPasswordClick(in controller: LoginIndexViewController) {
        print("on Forget Password Click")
    }
    
    func onCloseClick(in controller: LoginIndexViewController) {
        print("on Close Click")
    }
    
    func onBackClick(in controller: LoginIndexViewController) {
        print("on Back Click")
    }
}
