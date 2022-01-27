//
//  LoginHandlerTests.swift
//  HandlersTests
//
//  Created by Nykolas Mayko Maia Barbosa on 25/01/22.
//

import Quick
import Nimble
import Core
import Login

@testable import App


class LoginHandlerSpec: QuickSpec {
    
    override func spec() {
        describe("A Login Handler") {
            
            context("after being properly initialized") {
                let mockAppNavigation = MockAppNavigation()
                let mockBaseFlowDelegate = MockBaseFlowDelegate()
                let mockBaseFlowDataSource = MockBaseFlowDataSource()
                
                it("should have name") {
                    let sut = LoginHandler(appNavigation: AppNavigation())
                    expect(sut.getName()).to(equal("login"))
                }
                
                it("should can start") {
                    let sut = LoginHandler(appNavigation: AppNavigation())
                    expect(sut.canStart()).to(beTrue())
                }
                
                it("should start and return the LoginIndexViewController") {
                    let sut = LoginHandler(appNavigation: AppNavigation())
                    expect(sut.start(from: nil, with: mockBaseFlowDelegate, mockBaseFlowDataSource, nil, nil, nil)).to(beAKindOf(LoginIndexViewController.self))
                }
                
                it("should start and return the ForgotPasswordViewController when subJourney is equal to .forgotPassword") {
                    let sut = LoginHandler(appNavigation: AppNavigation())
                    
                    expect(sut.start(from: nil, with: mockBaseFlowDelegate, mockBaseFlowDataSource, nil, .forgotPassword, nil)).to(beAKindOf(ForgotPasswordViewController.self))
                }
                
                it("should handleGet from profile and return a LoginIndexViewController") {
                    let sut = LoginHandler(appNavigation: mockAppNavigation)
                    
                    mockAppNavigation.register([.login], with: sut)
                    
                    expect(sut.handleGet(from: .profile, to: nil, with: mockBaseFlowDelegate, analytics: nil)).to(beAKindOf(LoginIndexViewController.self))
                }
                
                it("should handleGet from FakeJourney and return a LoginIndexViewController") {
                    let sut = LoginHandler(appNavigation: mockAppNavigation)
                    
                    mockAppNavigation.register([.login], with: sut)
                    
                    expect(sut.handleGet(from: .init(rawValue: "FakeJourney"), to: nil, with: mockBaseFlowDelegate, analytics: nil)).to(beAKindOf(LoginIndexViewController.self))
                }
            }
        }
    }
}


