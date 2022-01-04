//
//  ChipFlow.swift
//  ChipFramework
//
//  Created by Avanade on 23/12/21.
//

import UIKit
import Core

protocol ChipHomeFlowProtocol: class {
    var factory: ChipViewControllerFactory { get }
    var delegate: ChipFlowDelegate? { get set }
    var deeplink: Deeplink<ChipDeeplink>? { get set }
    func start() -> UIViewController
}

public protocol ChipFlowDelegate: class {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?)
}

class ChipFlow: ChipHomeFlowProtocol, Deeplinkable {
    
    var factory: ChipViewControllerFactory
    var deeplink: Deeplink<ChipDeeplink>?
    
    weak var delegate: ChipFlowDelegate?
    
    init(factory: ChipViewControllerFactory, deeplink: Deeplink<ChipDeeplink>) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeChipViewController(flow: self)
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

// MARK: - ChipFlowDelegate implementation
extension ChipFlow: ChipFlowProtocol {
    func openProfile(in controller: ChipViewController) {
        delegate?.goToProfile(from: .main, in: controller, with: nil)
    }
}

