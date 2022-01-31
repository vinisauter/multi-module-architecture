//
//  LoginFlowTests.swift
//  LoginFlowTests
//
//  Created by Nykolas Mayko Maia Barbosa on 28/01/22.
//

import XCTest
import Nimble
import Core

@testable import Login

class LoginFlowTests: XCTestCase {

    func testStartShouldReturnLoginIndexViewController() {
        let sut = makeSUT()
        
        expect(sut.start()).to(beAKindOf(LoginIndexViewController.self))
    }
    
    func testResolveDeeplinkIfNeedShouldNotShowWhenDeeplinkIsIndex() {
        let sut = makeSUT(with: Deeplink<LoginDeeplink>(value: .index, url: URL(string: "app://")!))
        
        let someViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: someViewController)
        sut.resolveDeeplinkIfNeeded(from: someViewController)
        
        expect(navigationController.viewControllers.count).to(equal(1))
    }
    
    func testResolveDeeplinkIfNeedShouldShowForgotPasswordViewControllerWhenDeeplinkIsForgotPassword() {
        let sut = makeSUT(with: Deeplink<LoginDeeplink>(value: .forgotPassword, url: URL(string: "app://")!))
        
        let someViewController = UIViewController()
        let navigationController = NotAnimatedNavigationController(rootViewController: someViewController)
        sut.resolveDeeplinkIfNeeded(from: someViewController)
        
        expect(navigationController.viewControllers.last).to(beAKindOf(ForgotPasswordViewController.self))
    }
    
    func testOnForgotPasswordClickShouldGoToForgotPasswordViewController() {
        let sut = makeSUT()
        
        let loginVC = LoginIndexViewController(viewModel: nil)
        let navigationController = NotAnimatedNavigationController(rootViewController: loginVC)
        
        sut.onForgotPasswordClick(in: loginVC)
        
        expect(navigationController.viewControllers.last).to(beAKindOf(ForgotPasswordViewController.self))
    }
    
    func testOnChangePasswordSuccessShouldPopToLoginIndexViewController() {
        let sut = makeSUT()
        
        let loginVC = LoginIndexViewController(viewModel: nil)
        let forgotPasswordVC = ForgotPasswordViewController(viewModel: nil)
        let navigationController = NotAnimatedNavigationController()
        navigationController.setViewControllers([loginVC, forgotPasswordVC], animated: false)
        
        
        sut.onChangePasswordSuccess(in: forgotPasswordVC)
        
        expect(navigationController.viewControllers.last).to(beAKindOf(LoginIndexViewController.self))
    }
    
    // MARK: - Helpers
    
    let mockLoginViewControllerFactory = LoginViewControllerFactory(businessModel: nil, defaultAnalytics: nil, customAnalytics: nil)
    
    func makeSUT(with deeplink: Deeplink<LoginDeeplink>? = nil) -> LoginFlow {
        return LoginFlow(factory: mockLoginViewControllerFactory, deeplink: deeplink)
    }
    
    class NotAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
}
