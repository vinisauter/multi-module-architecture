//
//  LoginAPITests.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import XCTest
import NetworkingInterfaces
@testable import Login

final class LoginAPITests: XCTestCase {
    
    private var sut: LoginRepositoryProtocol!
    
    private var secureHttpClientSpy: SecureHttpClientSpy!
    private var insecureHttpClientSpy: InsecureHttpClientSpy!
    
    func test_sut_loadQuickly() {
        measure {
            _ = LoginAPI(secureHttpClient: SecureHttpClientSpy(), insecureHttpClient: InsecureHttpClientSpy())
        }
    }
    
    override func setUp() {
        secureHttpClientSpy = SecureHttpClientSpy()
        insecureHttpClientSpy = InsecureHttpClientSpy()
        
        sut = LoginAPI(secureHttpClient: secureHttpClientSpy, insecureHttpClient: insecureHttpClientSpy)
    }
    
    override func tearDown() {
        sut = nil
        
        secureHttpClientSpy = nil
        insecureHttpClientSpy = nil
    }
    
    // MARK: - Simple Sut Instance Test
    func test_sut_simpleInstance() {
        XCTAssertNotNil(sut, "Sut shouldn't be nil")
    }
    
    // MARK: - Login Tests
    func test_login_requestData() {
        sut?.login(with: "", and: "", completion: { _ in })
        
        XCTAssertEqual(secureHttpClientSpy.urls, ["http://www.example.com/"], "It Should be equal to array with 1 url elements")
    }
    
    func test_loginTwice_requestData() {
        sut?.login(with: "", and: "", completion: { _ in })
        sut?.login(with: "", and: "", completion: { _ in })
        
        XCTAssertEqual(secureHttpClientSpy.urls, ["http://www.example.com/","http://www.example.com/"], "It Should be equal to array with 2 url elements")
    }
    
    func test_login_validCredentials() {
        sut?.login(with: "username", and: "password", completion: { _ in })
        
        XCTAssertEqual(secureHttpClientSpy.requestValue, ["username:password"], "It should have been authenticated")
    }
    
    func test_login_validAutentication() {
        var result = [Bool]()
        secureHttpClientSpy.result = "valid"
        
        sut?.login(with: "username", and: "password", completion: { loginResult in
            result.append(loginResult)
        })
        
        XCTAssertEqual(result, [true], "It should have been authenticated")
    }
    
    
    func test_login_invalidAutentication() {
        var result = [Bool]()
        secureHttpClientSpy.result = "inValid"
        
        sut?.login(with: "username", and: "password", completion: { loginResult in
            result.append(loginResult)
        })
        
        XCTAssertEqual(result, [false], "It should have been authenticated")
    }
    
    // MARK: - Change Password Tests
//    func test_changePassword_requestData() {
//        sut?.changePassword(with: "", completion: { _ in })
//        
//        XCTAssertEqual(secureHttpClientSpy.urls, ["http://www.example.com/"], "It Should be equal to array with 1 url elements")
//    }

}
