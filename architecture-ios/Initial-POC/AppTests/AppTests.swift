//
//  AppTests.swift
//  AppTests
//
//  Created by ACT on 01/02/22.
//

import XCTest

import App

import Login

import Networking
import NetworkingInterfaces
import Core
import Analytics
import AnalyticsInterfaces

class AppTests: XCTestCase {

    private var mockLoginRepository:MockLoginRepository?
    private var mockLoginStructuralAnalytics:MockLoginStructuralAnaltytics?
    private var mockLoginBunissesModel:MockBunissesModel?
    
    override func setUpWithError() throws {
        self.mockLoginRepository = MockLoginRepository()
        self.mockLoginStructuralAnalytics = MockLoginStructuralAnaltytics()
        self.mockLoginBunissesModel = MockBunissesModel(repository: self.mockLoginRepository!, structuralAnalytics: self.mockLoginStructuralAnalytics!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testAllParametersOfTheViewModelReceiveSuccessfully() throws {
        //  mock flow
        let mockFLow = MockLoginFlow()
        
        // error converte analytics LoginIndex Analytics Protocol
        let viewModel = LoginIndexViewModel(businessModel: self.mockLoginBunissesModel, analytics: self.mockLoginBunissesModel, flowDelegate: mockFLow)
        
        XCTAssertNotNil(viewModel.businessModel)
        XCTAssertNotNil(viewModel.flowDelegate)
        XCTAssertNotNil(viewModel.analytics)
    }
    
    func testAllParametersAreNotreceivedSucessfully() throws{
        
        let viewModel = LoginIndexViewModel(businessModel: nil, analytics: nil, flowDelegate: nil)
        
        XCTAssertNil(viewModel.businessModel)
        XCTAssertNil(viewModel.flowDelegate)
        XCTAssertNil(viewModel.analytics)
    }
    
    func testClassTypeIsMatches() throws{
        
        let mockFLow = MockLoginFlow()
        
        let viewModel = LoginIndexViewModel(businessModel: self.mockLoginBunissesModel, analytics: self.mockLoginBunissesModel, flowDelegate: mockFLow)
        
        guard (type(of: viewModel.businessModel!) == type(of:self.mockLoginBunissesModel!)) else {
            XCTFail("Not Match BuninessModel type")
            return
        }
        
        guard (type(of: viewModel.analytics!) == type(of:self.mockLoginBunissesModel!)) else {
            XCTFail("Not Match BuninessModel type")
            return
        }
        
        guard (type(of: viewModel.flowDelegate!) == type(of:mockFLow)) else {
            XCTFail("Not Match FLow Delegate type")
            return
        }
        
    }
    
    
//    func assertEqual<T:BidirectionalCollection>(_ first: T){
//        first.difference(from: <#T##BidirectionalCollection#>, by: <#T##(BidirectionalCollection.Element, T.Element) -> Bool#>)
//    }
    
}
