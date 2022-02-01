//
//  AppTests.swift
//  AppTests
//
//  Created by ACT on 28/01/22.
//

import Foundation
import XCTest
import Cuckoo
import Profile
import App
import AnalyticsInterfaces

class ProfileAnalytics: AnalyticsProtocol{
    func track(tag: String) {
        print("TRANK: profile analytics")
    }
}

class AppTests: XCTestCase {
    
    private var mockAdapter:MockLoginAnalyticsProfileAdapter?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let structural = StructuralDependencyProvider.shared
        let profileAPI = ProfileAPI(httpClient: structural.networkingProvider.getSecureHttpClient())
        let bunisses = ProfileBusinessModel(repository: profileAPI, structuralAnalytics: ProfileAnalytics())
        self.mockAdapter = MockLoginAnalyticsProfileAdapter(profileAnalytics: bunisses).withEnabledSuperclassSpy()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTA/Users/act/Documents/nextarchitecture/architecture-ios/Initial-POC/Modules/Journey/Profile/Profile/Repository/ProfileAPI.swiftssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        stub(self.mockAdapter!){ stub in
            when(stub.structuralAnalytics).get.thenReturn(ProfileAnalytics())
            when(stub.onLoginClick()).thenDoNothing()
            when(stub.onChangePasswordClick()).thenDoNothing()
            when(stub.onForgotPasswordClick()).thenDoNothing()
        }
        self.mockAdapter!.onLoginClick()
//        atLeastOnce()
        self.mockAdapter!.onChangePasswordClick()
        self.mockAdapter!.onForgotPasswordClick()
        verify(self.mockAdapter!).onLoginClick()
        verify(self.mockAdapter!).onChangePasswordClick()
        verify(self.mockAdapter!).onForgotPasswordClick()
//        measure {
//           Put the code you want to measure the time of here.
//        }
    }

}

extension ProfileAnalytics: Matchable{
    
    var matcher: ParameterMatcher<ProfileAnalytics> {
        return equal(to:self)
    }

}
