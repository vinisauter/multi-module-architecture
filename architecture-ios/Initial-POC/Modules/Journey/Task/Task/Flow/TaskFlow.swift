//
//  TaskFlow.swift
//  Task
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import UIKit
import Core

protocol TaskFlowProtocol: AnyObject {
    var factory: TaskViewControllerFactory { get }
    var delegate: TaskFlowDelegate? { get set }
    var deeplink: Deeplink<TaskDeeplink>? { get set }
    func start() -> UIViewController
}

public protocol TaskFlowDelegate: AnyObject {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?)
}

class TaskFlow: TaskFlowProtocol, Deeplinkable {
    var factory: TaskViewControllerFactory
    
    var deeplink: Deeplink<TaskDeeplink>?
    
    weak var delegate: TaskFlowDelegate?
    
    init(factory: TaskViewControllerFactory, deeplink: Deeplink<TaskDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeTaskViewController(isIndex: true)
    }
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink, let screen = deeplink.value, let url = deeplink.url else { return }
        self.deeplink = nil
        
        switch screen {
        case .index: break
        }
    }
}

