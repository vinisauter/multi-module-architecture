//
//  LoginAPITests.swift
//  LoginTests
//
//  Created by ACT on 25/01/22.
//

import XCTest
import NetworkingInterfaces
import Nimble

@testable import Login

final class LoginAPITests: XCTestCase {
    
    func test_sut_loadQuickly() {
        measure {
            _ = LoginAPI(secureHttpClient: SecureHttpClientFake(), insecureHttpClient: InsecureHttpClientFake())
        }
    }
    
    // MARK: - Simple Sut Instance Test
    func test_sut_simpleInstance() {
        let (sut, _, _) = makeSut()
        
        expect(sut).toNot(beNil(), description: "Sut shouldn't be nil")
    }
    
    // MARK: - Login Tests
    func test_login_requestURLIntegrity() {
        let (sut, secureClient, _) = makeSut()
        sut.login(with: "", and: "", completion: { _ in })
        
        expect(secureClient.urls).to(equal(["http://www.example.com/"]), description: "It Should be equal to array with 1 url elements")
    }
    
    func test_loginTwice_requestURLIntegrity() {
        let (sut, secureClient, _) = makeSut()
        sut.login(with: "", and: "", completion: { _ in })
        sut.login(with: "", and: "", completion: { _ in })
        
        expect(secureClient.urls).to(equal(["http://www.example.com/","http://www.example.com/"]), description: "It Should be equal to array with 2 url elements")
    }
    
    func test_login_credentialsIntegrity() {
        let (sut, secureClient, _) = makeSut()
        sut.login(with: "username", and: "password", completion: { _ in })
        
        expect(secureClient.requestValue).to(equal(["username:password"]), description: "It should have credentials integrity")
    }
    
    func test_login_validRequest() {
        let (sut, secureClient, _) = makeSut()
        var result = [Result<String, NetworkError>]()
        secureClient.result = "valid"
        
        sut.login(with: "username", and: "password", completion: { loginResult in
            
            result.append(loginResult)
        })
        
        let reference: [Result<String, NetworkError>] = [.success("valid")]
        expect(result).toEventually(equal(reference), description: "It should have been authenticated")
    }
    
    func test_login_invalidAutentication() {
        let (sut, secureClient, _) = makeSut()
        var result = [Result<String, NetworkError>]()
        secureClient.result = "inValid"
        
        sut.login(with: "username", and: "password", completion: { loginResult in
            result.append(loginResult)
        })
        
        let reference: [Result<String, NetworkError>] = [.success("inValid")]
        expect(result).toEventually(equal(reference), description: "It shouldn't have been authenticated")
    }
    
    func test_login_errorFromClient() {
        let (sut, secureClient, _) = makeSut()
        var result = [Result<String, NetworkError>]()
        secureClient.result = "error"
        
        sut.login(with: "", and: "", completion: { loginResult in
            result.append(loginResult)
        })
        
        let reference: [Result<String, NetworkError>] = [.failure(.error)]
        expect(result).toEventually(equal(reference), description: "It shouldn't have been authenticated")
    }
    
    // MARK: - Change Password Tests
    func test_changePassword_requestURLIntegrity() {
        let (sut, _, insecureClient) = makeSut()
        sut.changePassword(with: "", completion: { _ in })
        
        expect(insecureClient.urls).to(equal(["http://www.example.com/"]), description: "It Should be equal to array with 1 url elements")
    }
    
    func test_changePasswordTwice_requestURLIntegrity() {
        let (sut, _, insecureClient) = makeSut()
        sut.changePassword(with: "", completion: { _ in })
        sut.changePassword(with: "", completion: { _ in })

        expect(insecureClient.urls).to(equal(["http://www.example.com/","http://www.example.com/"]), description: "It Should be equal to array with 2 url elements")
    }
    
    func test_changePassword_newPasswordIntegrity() {
        let (sut, _, insecureClient) = makeSut()
        sut.changePassword(with: "password", completion: { _ in })

        expect(insecureClient.requestValue).to(equal(["password:password"]), description: "It should have new password integrity")
    }
    
    func test_changePassword_validRequest() {
        let (sut, _, insecureClient) = makeSut()
        var result = [Result<String, NetworkError>]()
        insecureClient.result = "valid"
        
        sut.changePassword(with: "", completion: { response in
            result.append(response)
        })

        let reference: [Result<String, NetworkError>] = [.success("valid")]
        expect(result).toEventually(equal(reference), description: "It should have valid request")
    }
    
    func test_changePassword_invalidPassword() {
        let (sut, _, insecureClient) = makeSut()
        var result = [Result<String, NetworkError>]()
        insecureClient.result = "inValid"
        
        sut.changePassword(with: "", completion: { response in
            result.append(response)
        })
        
        let reference: [Result<String, NetworkError>] = [.success("inValid")]
        expect(result).toEventually(equal(reference), description: "It shouldn't have been authenticated")
    }
    
    func test_changePassword_errorFromClient() {
        let (sut, _, insecureClient) = makeSut()
        var result = [Result<String, NetworkError>]()
        insecureClient.result = "error"
        
        sut.changePassword(with: "", completion: { response in
            result.append(response)
        })
        
        let reference: [Result<String, NetworkError>] = [.failure(.error)]
        expect(result).toEventually(equal(reference), description: "It shouldn't have been authenticated")
    }
    
    // MARK: - Helpers
    /// Instantiates sut and clients
    /// - Returns: LoginRepositoryProtocol, SecureHttpClientFake, InsecureHttpClientFake
    private func makeSut() -> (sut: LoginRepositoryProtocol, secureClient: SecureHttpClientFake, insecureClient: InsecureHttpClientFake) {
        let secureHttpClientSpy: SecureHttpClientFake = SecureHttpClientFake()
        let insecureHttpClientSpy: InsecureHttpClientFake = InsecureHttpClientFake()
        
        let sut: LoginRepositoryProtocol = LoginAPI(secureHttpClient: secureHttpClientSpy, insecureHttpClient: insecureHttpClientSpy)
        
        return (sut, secureHttpClientSpy, insecureHttpClientSpy)
    }


}
