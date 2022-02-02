//
//  NoteFlow.swift
//  Note
//
//  Created by Ailton Vieira Pinto Filho on 01/02/22.
//

import UIKit
import Core

protocol NoteFlowProtocol: AnyObject {
    var factory: NoteViewControllerFactory { get }
    var delegate: NoteFlowDelegate? { get set }
    var deeplink: Deeplink<NoteDeeplink>? { get set }
    func start() -> UIViewController
}

public protocol NoteFlowDelegate: AnyObject {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?)
}

class NoteFlow: NoteFlowProtocol, Deeplinkable {
    var factory: NoteViewControllerFactory
    
    var deeplink: Deeplink<NoteDeeplink>?
    
    weak var delegate: NoteFlowDelegate?
    
    init(factory: NoteViewControllerFactory, deeplink: Deeplink<NoteDeeplink>?) {
        self.factory = factory
        self.deeplink = deeplink
    }
    
    func start() -> UIViewController {
        return factory.makeNoteViewController(isIndex: true)
    }
    
    func resolveDeeplinkIfNeeded(from controller: UIViewController) {
        guard let deeplink = deeplink, let screen = deeplink.value, let url = deeplink.url else { return }
        self.deeplink = nil
        
        switch screen {
        case .index: break
        }
    }
}

