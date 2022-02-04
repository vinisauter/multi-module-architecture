//
//  ForgotPasswordTests.swift
//  LoginTests
//
//  Created by ACT on 04/02/22.
//

import XCTest
@testable import Login
import Nimble

class ForgotPasswordTests: XCTestCase {
    
    var sut : ForgotPasswordViewController?

    override func setUpWithError() throws {
        self.sut = ForgotPasswordViewController(viewModel: nil)
        self.sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func testIfHasButtonsNotReturnNil() {
        expect(self.sut?.button).toNot(beNil())
    }
    
    func testTitleForgotPasswordShouldReturnString() {
        expect(self.sut?.title).to(equal("Forgot Password"))
    }
    
    func testButtonForgotPasswordShouldReturnString(){
        expect(self.sut!.button.titleLabel?.text).to(equal("Change Password"))
    }

}
