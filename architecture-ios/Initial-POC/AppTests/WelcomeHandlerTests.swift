//
//  WelcomeHandlerTests.swift
//  AppTests
//
//  Created by ACT on 07/02/22.
//

import XCTest
import App
import Login
import Cuckoo
import Core

extension Journey {
    static let welcome: Journey = Journey(rawValue: "welcome")
    static let login: Journey = Journey(rawValue: "login")
    static let forgotPassword: Journey = Journey(rawValue: "forgotPassword")
    static let home: Journey = Journey(rawValue: "home")
    static let profile: Journey = Journey(rawValue: "profile")
}

class WelcomeHandlerTests: XCTestCase {
    
    let matcherJorneyWelcome = ParameterMatcher<Journey>{ match in
        switch match{
            case .welcome:
                return true
           default:
              return false
        }
    }
    
    let matcherJorneyProfile = ParameterMatcher<Journey>{ match in
        switch match{
            case .profile:
                return true
           default:
              return false
        }
    }
    
    func subMock() -> MockWelcomeHandler{
        return MockWelcomeHandler()
    }
    
    func makeSUT() -> WelcomeHandler{
        return WelcomeHandler()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    let matchNameWelcome = ParameterMatcher<Journey>{
        return $0.rawValue == Journey.welcome.rawValue
    }
    
    let matchURL = ParameterMatcher<URL>{
        return $0 == URL(string: "https://www.banknext.com")
    }
    
    func testTitleEqualHandler() throws{
        let mockWelcome = subMock()
        stub(mockWelcome) { (stub) in
            when(stub.getName()).thenReturn(Journey.welcome.rawValue)
        }
        XCTAssertEqual(mockWelcome.getName(), Journey.welcome.rawValue)
    }
    
    func testStartWhenSubJouneyNilShouldReturnWelcomeViewControler() throws{
        let mockWelcome = makeSUT()
        let mockBaseFlowDelegate = MockBaseFlowDelegate()
        let mockbaseFlowDataSource = MockBaseFlowDataSource()
        let viewController = mockWelcome.start(from: URL(string: "https://login"), with: mockBaseFlowDelegate, mockbaseFlowDataSource, nil, nil, nil)
        XCTAssertTrue(viewController.isKind(of: WelcomeViewController.self))
    }
    
    func testHandlerGetWhenIsFromFakeJourneyShouldReturnWelcomeViewController() throws{
        let mockNavigation = MockAppNavigation()
        let welcomeViewController = makeSUT()
        stub(mockNavigation) { (stub) in
            when(stub.register(any(), with: any())).thenDoNothing()
        }
        mockNavigation.register([.welcome], with: welcomeViewController)
        XCTAssertTrue(welcomeViewController.handleGet(from: .init(rawValue: "JourneyGet"), to: nil, with: MockBaseFlowDelegate(), analytics: nil).isKind(of: WelcomeViewController.self))
        verify(mockNavigation,times(1)).register(any(), with: any())
    }
    
    func testStartWhenSubJourneyIsNilShouldReturnWelcomeViewController() throws{
                    
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

