//
//  TaskLauncher.swift
//  Task
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import UIKit
import NetworkingInterfaces
import AnalyticsInterfaces
import Core

public struct TaskDependencies {
    var deeplink: URL?
    var flowDelegate: TaskFlowDelegate?
    let structuralDependencies: TaskStructuralDependencies
    var value: Any?
    
    public init (_ deeplink: URL?, _ flowDelegate: TaskFlowDelegate?, _ structuralDependencies: TaskStructuralDependencies, _ value: Any?) {
        self.deeplink = deeplink
        self.flowDelegate = flowDelegate
        self.structuralDependencies = structuralDependencies
        self.value = value
    }
}

public protocol TaskStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
}

public class TaskLauncher {
    static public func start(with dependencies: TaskDependencies) -> UIViewController {
        let factory = TaskViewControllerFactory()
        let mainFlow = TaskFlow(factory: factory, deeplink: Deeplink(value: TaskDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.delegate = dependencies.flowDelegate
        
        return mainFlow.start()
    }
}

// MARK: - Deeplink

enum TaskDeeplink: String, CaseIterable {
    case index = "/"
}

public enum Flow: CaseIterable {
    case main
}
