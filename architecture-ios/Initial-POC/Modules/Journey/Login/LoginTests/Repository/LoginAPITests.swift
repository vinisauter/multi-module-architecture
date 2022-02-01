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
    
    func test_sut_loadQuickly() {
        measure {
            _ = LoginAPI(secureHttpClient: SecureHttpClientSpy(), insecureHttpClient: InsecureHttpClientSpy())
        }
    }
    
    // MARK: - Simple Sut Instance Test
    func test_sut_simpleInstance() {
        let (sut, _, _) = makeSut()
        XCTAssertNotNil(sut, "Sut shouldn't be nil")
    }
    
    // MARK: - Login Tests
    func test_login_integrityOfrequestURL() {
        let (sut, secureClient, _) = makeSut()
        sut.login(with: "", and: "", completion: { _ in })
        
        XCTAssertEqual(secureClient.urls, ["http://www.example.com/"], "It Should be equal to array with 1 url elements")
    }
    
    func test_loginTwice_integrityOfrequestURL() {
        let (sut, secureClient, _) = makeSut()
        sut.login(with: "", and: "", completion: { _ in })
        sut.login(with: "", and: "", completion: { _ in })
        
        XCTAssertEqual(secureClient.urls, ["http://www.example.com/","http://www.example.com/"], "It Should be equal to array with 2 url elements")
    }
    
    func test_login_integrityOfCredentials() {
        let (sut, secureClient, _) = makeSut()
        sut.login(with: "username", and: "password", completion: { _ in })
        
        XCTAssertEqual(secureClient.requestValue, ["username:password"], "It should have integrity of credentials")
    }
    
    func test_login_validRequest() {
        let (sut, secureClient, _) = makeSut()
        var result = [Bool]()
        secureClient.result = "valid"
        
        sut.login(with: "username", and: "password", completion: { loginResult in
            result.append(loginResult)
        })
        
        XCTAssertEqual(result, [true], "It should have been authenticated")
    }
    
    func test_login_invalidAutentication() {
        let (sut, secureClient, _) = makeSut()
        var result = [Bool]()
        secureClient.result = "inValid"
        
        sut.login(with: "username", and: "password", completion: { loginResult in
            result.append(loginResult)
        })
        
        XCTAssertEqual(result, [false], "It should have been authenticated")
    }
    
    func test_login_errorFromClient() {
        let (sut, secureClient, _) = makeSut()
        var result = [Bool]()
        secureClient.result = "error"
        
        sut.login(with: "", and: "", completion: { loginResult in
            result.append(loginResult)
        })
        
        XCTAssertEqual(result, [false], "It shouldn't have been authenticated")
    }
    
    // MARK: - Change Password Tests
//    func test_login_requestData() {
//        let (sut, secureClient, _) = makeSut()
//        sut.login(with: "", and: "", completion: { _ in })
//
//        XCTAssertEqual(secureClient.urls, ["http://www.example.com/"], "It Should be equal to array with 1 url elements")
//    }
    
    // MARK: - Helpers
    private func makeSut() -> (sut: LoginRepositoryProtocol, secureClient: SecureHttpClientSpy, insecureClient: InsecureHttpClientSpy) {
        let secureHttpClientSpy: SecureHttpClientSpy = SecureHttpClientSpy()
        let insecureHttpClientSpy: InsecureHttpClientSpy = InsecureHttpClientSpy()
        
        let sut: LoginRepositoryProtocol = LoginAPI(secureHttpClient: secureHttpClientSpy, insecureHttpClient: insecureHttpClientSpy)
        
        return (sut, secureHttpClientSpy, insecureHttpClientSpy)

    }

}
