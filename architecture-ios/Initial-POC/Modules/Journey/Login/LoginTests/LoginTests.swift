//
//  LoginTests.swift
//  LoginTests
//
//  Created by ACT on 01/02/22.
//

import XCTest
import Nimble
import Core

@testable import Login

final class LoginTests: XCTestCase {

    var loginViewController : LoginIndexViewController?
    var forgotviewController : ForgotPasswordViewController?
    var loginButton: UIButton?
    var forgotButton: UIButton?
    
    override func setUpWithError() throws {
        self.loginViewController = LoginIndexViewController(viewModel: nil)
        self.forgotviewController = ForgotPasswordViewController(viewModel: nil)
    
        self.loginViewController?.loadViewIfNeeded()
        self.forgotviewController?.loadViewIfNeeded()
        
        self.loginButton = self.loginViewController!.button
        self.forgotButton = self.loginViewController!.forgotPasswordbutton
    }

    override func tearDownWithError() throws {
        self.loginViewController = nil
        self.forgotviewController = nil
    }
    
    func testIfHasButtons() {
        XCTAssertNotNil(self.loginButton, "O ViewController não possui a propriedade LoginButton")
        XCTAssertNotNil(self.forgotButton, "O ViewController não possui a propriedade ForgotPassword")
    }
    
    func testRenderLogin() {
        XCTAssertEqual(self.loginViewController!.title, "Login")
        XCTAssertEqual(self.loginButton?.titleLabel?.text, "Login")
        XCTAssertEqual(self.forgotButton?.titleLabel?.text, "Forgot Password")
        XCTAssertEqual(self.loginViewController?.navigationItem.leftBarButtonItem?.title, "Fechar")
        
        XCTAssertTrue(((self.loginViewController?.loadingContainer.isHidden) != nil))
    }
    
    func testRenderForgotPassword() {
        XCTAssertEqual(self.forgotviewController!.title, "Forgot Password")
        XCTAssertEqual(self.forgotviewController!.button.titleLabel?.text, "Change Password")
    }
}
