//
//  TaskHandler.swift
//  App
//
//  Created by Ailton Vieira Pinto Filho on 19/01/22.
//

import UIKit
import Core
import Task
import FlutterModule

class TaskHandler: ModuleHandler {
    private weak var baseFlowDelegate: BaseFlowDelegate?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let taskDependencies = TaskDependencies(url, self, StructuralDependencyProvider.shared, FlutterModule.shared, value)
        return TaskLauncher.start(with: taskDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        return Journey.task.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .login:
            AppNavigation.shared.show([.login], from: viewController, animated: false)
            isUserLoggedIn = false
            break
        case .task:
            AppNavigation.shared.show([.task], from: viewController, animated: true)
            
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        return start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
    }
}

extension StructuralDependencyProvider: TaskStructuralDependencies {}

extension TaskHandler: TaskFlowDelegate {
    func didFinish(_ flow: Flow, in controller: UIViewController, with value: Any?) {
        
    }
}
