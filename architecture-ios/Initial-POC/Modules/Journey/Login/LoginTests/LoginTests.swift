//
//  LoginTests.swift
//  LoginTests
//
//  Created by ACT on 01/02/22.
//

import XCTest
@testable import Login

final class LoginTests: XCTestCase {

    var sut : LoginIndexViewController?
    var loginButton: UIButton?
    var forgotButton: UIButton?
    
    override func setUpWithError() throws {
        self.sut = LoginIndexViewController(viewModel: nil)
        self.sut?.loadViewIfNeeded()
        self.sut?.viewWillAppear(true)
        self.loginButton = self.sut?.button
        self.forgotButton = self.sut?.forgotPasswordbutton
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func testIfHasLoginNotReturnNil() {
        XCTAssertNotNil(self.loginButton, "O ViewController não possui a propriedade LoginButton")
    }
    
    func testIfHasForgotButtonNotReturnNil(){
        XCTAssertNotNil(self.forgotButton, "O ViewController não possui a propriedade ForgotPassword")
    }
    
    func testRenderTitleShouldReturnString() {
        XCTAssertEqual(self.sut?.title, "Login")
    }
    
    func testRenderLoginButtonTitleShouldReturnString(){
        XCTAssertEqual(self.loginButton?.titleLabel?.text, "Login")
    }
    
    func testRenderForgotButtonTitleShouldReturnString(){
        XCTAssertEqual(self.forgotButton?.titleLabel?.text, "Forgot Password")
    }
    
    func testRenderLeftBarButtonTitleReturnString(){
        XCTAssertEqual(self.sut?.navigationItem.leftBarButtonItem?.title, "Fechar")
    }
    
    func testRenderLoadingContainerIsHidden(){
        XCTAssertTrue(((self.sut?.loadingContainer.isHidden) != nil))
    }
}
