//
//  BusinessModelTests.swift
//  BusinessModelTests
//
//  Created by Nykolas Mayko Maia Barbosa on 27/01/22.
//

import XCTest
import Nimble
import AnalyticsInterfaces

@testable import Login


class BusinessModelTests: XCTestCase {
    func testLoginWhShouldReturnSuccessTrueWhenIsPassedAValidUsernameAndPassword() {
        let sut = makeSUT(loginRepository: mockSucessLoginRepository)
        
        var loginIsSuccess: Bool = false
        sut.login(with: "success_username", and: "success_password") { success in
            loginIsSuccess = success
        }
        
        expect(loginIsSuccess).toEventually(beTrue())
    }
    
    func testLoginShoudReturnSucessFalseIsPassedAValidUsernameAndInvalidPassword() {
        let sut = makeSUT(loginRepository: mockFailureLoginRepository)
        
        var loginIsSuccess: Bool = true
        sut.login(with: "valid_username", and: "invalid_password") { success in
            loginIsSuccess = success
        }
        
        expect(loginIsSuccess).toEventually(beFalse())
    }
    
    func testLoginShoudReturnSucessFalseIsPassedAInvalidUsernameAndValidPassword() {
        let sut = makeSUT(loginRepository: mockFailureLoginRepository)
        
        var loginIsSuccess: Bool = true
        sut.login(with: "invalid_username", and: "valid_password") { success in
            loginIsSuccess = success
        }
        
        expect(loginIsSuccess).toEventually(beFalse())
    }
    
    func testLoginShoudReturnSucessFalseIsPassedAInvalidUsernameAndPassword() {
        let sut = makeSUT(loginRepository: mockFailureLoginRepository)
        
        var loginIsSuccess: Bool = true
        sut.login(with: "invalid_username", and: "invalid_password") { success in
            loginIsSuccess = success
        }
        
        expect(loginIsSuccess).toEventually(beFalse())
    }
    
    func testChangePasswordShouldReturnSuccessTrueWhenIsPassedAValidPassword() {
        let sut = makeSUT(loginRepository: mockSucessLoginRepository)
        
        var hasChangedPassword: Bool = false
        sut.changePassword(with: "valid_new_password") { success in
            hasChangedPassword = success
        }
        
        expect(hasChangedPassword).toEventually(beTrue())
    }
    
    func testChangePasswordShouldReturnSuccessFalseWhenIsPassedAInvalidPassword() {
        let sut = makeSUT(loginRepository: mockFailureLoginRepository)
        
        var hasChangedPassword: Bool = true
        sut.changePassword(with: "invalid_new_password") { success in
            hasChangedPassword = success
        }
        
        expect(hasChangedPassword).toEventually(beFalse())
    }
    
    func testOnForgotPasswordClickShouldSendOnForgotPassworTrackTag() {
        let sut = makeSUT(loginRepository: mockSucessLoginRepository)
        
        sut.onForgotPasswordClick()
        
        expect(self.mockStructuralAnalytics.trackedTag) == "LOGIN - onForgotPassword track"
    }
    
    func testOnLoginClickShouldSendOnLoginTrackTag() {
        let sut = makeSUT(loginRepository: mockSucessLoginRepository)
        
        sut.onLoginClick()
        
        expect(self.mockStructuralAnalytics.trackedTag).to(equal("LOGIN - onLoginClick track"))
    }
    
    func testOnChangePasswordClickShouldSendOnChangePasswordTrackTag() {
        let sut = makeSUT(loginRepository: mockSucessLoginRepository)
        
        sut.onChangePasswordClick()
        
        XCTAssertEqual(self.mockStructuralAnalytics.trackedTag, "LOGIN/FORGOT PASSWORD - onChangePasswordClick track")
    }
    
    // MARK: - Helpers
    
    let mockSucessLoginRepository = MockSucessLoginRepository()
    let mockFailureLoginRepository = MockFailureLoginRepository()
    let mockStructuralAnalytics = MockStructuralAnalytics()
    
    func makeSUT(loginRepository: LoginRepositoryProtocol) -> LoginBusinessModel {
        return LoginBusinessModel(repository: loginRepository, structuralAnalytics: mockStructuralAnalytics)
    }

    class MockSucessLoginRepository: LoginRepositoryProtocol {
        func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
            completion(true)
        }
        
        func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
            completion(true)
        }
    }
    
    class MockFailureLoginRepository: LoginRepositoryProtocol {
        func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
            completion(false)
        }
        
        func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
            completion(false)
        }
    }
    
    class MockStructuralAnalytics: AnalyticsProtocol {
        var trackedTag: String = ""
        
        func track(tag: String) { self.trackedTag = tag }
    }
}
