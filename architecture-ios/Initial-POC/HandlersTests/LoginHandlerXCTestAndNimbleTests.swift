//
//  LoginHandlerXCTestAndNimbleTests.swift
//  HandlersTests
//
//  Created by Nykolas Mayko Maia Barbosa on 26/01/22.
//

import XCTest
import Nimble
import Core
import Login

@testable import App

class LoginHandlerXCTestAndNimbleTests: XCTestCase {

    func testGetNameShouldReturnLoginName() {
        expect(self.makeSUT().getName()) == "login"
    }

    func testCanStartShouldReturnTrue() {
        expect(self.makeSUT().canStart()).to(beTrue())
    }
    
    func testStartWhenSubJorneyIsNilShouldReturnLoginIndexViewController() {
        expect(self.makeSUT().start(from: nil, with: self.mockBaseFlowDelegate, self.mockBaseFlowDataSource, nil, nil, nil)).to(beAKindOf(LoginIndexViewController.self))
    }
    
    func testStartWhenSubJorneyIsFogotPasswordShouldReturnForgotPasswordViewController() {
        expect(self.makeSUT().start(from: nil, with: self.mockBaseFlowDelegate, self.mockBaseFlowDataSource, nil, .forgotPassword, nil)).to(beAKindOf(ForgotPasswordViewController.self))
    }
    
    func testHandleGetWhenIsFromProfileShouldReturnLoginIndexViewController() {
        let sut = makeSUT()
        
        mockAppNavigation.register([.login], with: sut)
        
        expect(sut.handleGet(from: .profile, to: nil, with: self.mockBaseFlowDelegate, analytics: nil)).to(beAKindOf(LoginIndexViewController.self))
    }
    
    func testHandleGetWhenIsFromFakeJourneyShouldReturnLoginIndexViewController() {
        let sut = makeSUT()
        
        mockAppNavigation.register([.login], with: sut)
        
        expect(sut.handleGet(from: .init(rawValue: "FakeJourney"), to: nil, with: self.mockBaseFlowDelegate, analytics: nil)).to(beAKindOf(LoginIndexViewController.self))
    }
    
    // MARK: - Helpers
    
    let mockBaseFlowDelegate = MockBaseFlowDelegate()
    let mockBaseFlowDataSource = MockBaseFlowDataSource()
    let mockAppNavigation = MockAppNavigation()
    
    func makeSUT() -> LoginHandler {
        return LoginHandler(appNavigation: mockAppNavigation)
    }
}
