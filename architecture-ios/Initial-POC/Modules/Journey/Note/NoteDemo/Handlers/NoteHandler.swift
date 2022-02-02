//
//  NoteHandler.swift
//  NoteDemo
//
//  Created by Ailton Vieira Pinto Filho on 02/02/22.
//

import UIKit
import Core
import Note

class NoteHandler: ModuleHandler {
    private weak var baseFlowDelegate: BaseFlowDelegate?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let noteDependencies = NoteDependencies(url, self, StructuralDependencyProvider.shared, value)
        return NoteLauncher.start(with: noteDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        return Journey.note.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .login:
            AppNavigation.shared.show([.login], from: viewController, animated: false)
            isUserLoggedIn = false
            break
        case .note:
            AppNavigation.shared.show([.note], from: viewController, animated: true)
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
    }
}

extension StructuralDependencyProvider: NoteStructuralDependencies {}

extension NoteHandler: NoteFlowDelegate {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?) {
        
    }
}
