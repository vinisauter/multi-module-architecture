//
//  VaquinhaFlow.swift
//  VaquinhaFramework
//
//  Created by Avanade on 23/12/21.
//

import UIKit
import Core

protocol VaquinhaHomeFlowProtocol: class {
    var factory: VaquinhaViewControllerFactory { get }
    var delegate: VaquinhaFlowDelegate? { get set }
    var deeplink: Deeplink<VaquinhaDeeplink>? { get set }
    func start() -> UIViewController
}

public protocol VaquinhaFlowDelegate: class {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?)
}

class VaquinhaFlow: VaquinhaHomeFlowProtocol, Deeplinkable {
    
    var factory: VaquinhaViewControllerFactory
    var deeplink: Deeplink<VaquinhaDeeplink>?
    
    weak var delegate: VaquinhaFlowDelegate?
    
    init(factory: VaquinhaViewControllerFactory, deeplink: Deeplink<VaquinhaDeeplink>) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeVaquinhaViewController()
    }
    
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink,
              let screen = deeplink.value
        else { return }
        
        self.deeplink = nil
        
        switch screen {
        case .home: break
        }
    }
}

// MARK: - VaquinhaFlowDelegate implementation
extension VaquinhaFlow: VaquinhaFlowProtocol {
    func openProfile(in controller: VaquinhaViewController) {
        delegate?.goToProfile(from: .main, in: controller, with: nil)
    }
}

