//
//  LoginAPITests.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import XCTest
import NetworkingInterfaces
@testable import Login

class LoginAPITests: XCTestCase {
    
    var sut: LoginRepositoryProtocol? = nil
    
    override func setUp() {
        let secureHttpClientDummy: HTTPClientProtocol = SecureHttpClientDummy()
        let insecureHttpClientDummy: HTTPClientProtocol = InsecureHttpClientDummy()
        
        sut = LoginAPI(secureHttpClient: secureHttpClientDummy, insecureHttpClient: insecureHttpClientDummy)
    }
    
    // MARK: - Simple Instance Test
    func testSimpleSutInstance() throws {
        XCTAssertNotNil(sut, "Sut shouldn't be nil")
    }
    
    // MARK: - Login Tests
    func testExample() throws {
        
    }

}
