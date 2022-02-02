//
//  NoteLauncher.swift
//  Note
//
//  Created by Ailton Vieira Pinto Filho on 01/02/22.
//

import UIKit
import NetworkingInterfaces
import AnalyticsInterfaces
import FlutterManagerInterfaces
import Core

public struct NoteDependencies {
    var deeplink: URL?
    var flowDelegate: NoteFlowDelegate?
    let structuralDependencies: NoteStructuralDependencies
    var value: Any?
    
    public init (_ deeplink: URL?, _ flowDelegate: NoteFlowDelegate?, _ structuralDependencies: NoteStructuralDependencies, _ value: Any?) {
        self.deeplink = deeplink
        self.flowDelegate = flowDelegate
        self.structuralDependencies = structuralDependencies
        self.value = value
    }
}

public protocol NoteStructuralDependencies {
    var networkingProvider: NetworkingProviderProtocol { get }
    var analytics: AnalyticsProtocol { get }
    var flutterManager: FlutterManagerProtocol { get }
}

public class NoteLauncher {
    static public func start(with dependencies: NoteDependencies) -> UIViewController {
        let factory = NoteViewControllerFactory(flutterManager: dependencies.structuralDependencies.flutterManager)
        let mainFlow = NoteFlow(factory: factory, deeplink: Deeplink(value: NoteDeeplink(rawValue: dependencies.deeplink?.path ?? "/"), url: dependencies.deeplink))
        mainFlow.delegate = dependencies.flowDelegate
        
        return mainFlow.start()
    }
}

// MARK: - Deeplink

enum NoteDeeplink: String, CaseIterable {
    case index = "/"
}

public enum Flow: CaseIterable {
    case main
}
