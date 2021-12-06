//
//  HomeFlow.swift
//  Home
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core

protocol HomeFlowProtocol: AnyObject {
    var factory: HomeViewControllerFactory { get }
    var delegate: HomeFlowDelegate? { get set }
    var deeplink: Deeplink<HomeDeeplink>? { get set }
    func start() -> UIViewController
}

public protocol HomeFlowDelegate: AnyObject {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?)
    func goToLogin(from flow: Flow, in controller: UIViewController, with value: Any?)
}

class HomeFlow: HomeFlowProtocol, Deeplinkable {
    var factory: HomeViewControllerFactory
    
    var deeplink:  Deeplink<HomeDeeplink>?
    
    weak var delegate: HomeFlowDelegate?
    
    init(factory: HomeViewControllerFactory, deeplink:  Deeplink<HomeDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeHomeIndexViewController()
    }
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink, let screen = deeplink.value else { return }
        self.deeplink = nil
        
        switch screen {
        case .index: break
        }
    }
}

// MARK: - HomeIndexFlowDelegate

extension HomeFlow: HomeIndexFlowDelegate {
    func logout(in controller: HomeIndexViewController) {
        delegate?.goToLogin(from: .main, in: controller, with: nil)
    }
    
    func openProfile(in controller: HomeIndexViewController) {
        delegate?.goToProfile(from: .main, in: controller, with: nil)
    }
}
