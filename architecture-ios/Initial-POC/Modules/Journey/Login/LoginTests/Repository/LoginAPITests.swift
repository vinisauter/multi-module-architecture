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
    
    override func setUp() {
        secureHttpClientSpy = SecureHttpClientSpy()
        insecureHttpClientSpy = InsecureHttpClientSpy()
        
        sut = LoginAPI(secureHttpClient: secureHttpClientSpy, insecureHttpClient: insecureHttpClientSpy)
    }
    
    // MARK: - Simple Sut Instance Test
    func test_sut_simpleInstance() {
        XCTAssertNotNil(sut, "Sut shouldn't be nil")
    }
    
    // MARK: - Login Tests
    func test_login_requestData() {
        sut?.login(with: "a", and: "b", completion: { _ in })
        
        XCTAssertEqual(secureHttpClientSpy.urls, ["username:a password:b"], "It Should be equal to array with 1 url elements")
    }
    
    func test_loginTwice_requestData() {
        sut?.login(with: "a", and: "b", completion: { _ in })
        sut?.login(with: "a", and: "b", completion: { _ in })
        
        XCTAssertEqual(secureHttpClientSpy.urls, ["username:a password:b","username:a password:b"], "It Should be equal to array with 2 url elements")
    }
    
    func test_login_validAutentication() {
        var value = false
        
        sut?.login(with: "", and: "", completion: { result in
            value = result
        })

        XCTAssertEqual(value, true , "It should have been authenticated")
    }
    
    func test_login_invalidAutentication() {
        var value = false
        
        sut?.login(with: "", and: "", completion: { result in
            value = result
        })

        XCTAssertEqual(value, false , "It shouldn't have been authenticated")
    }

}
