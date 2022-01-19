//
//  FlutterModule.swift
//  FlutterModule
//
//  Created by Ailton Vieira Pinto Filho on 18/01/22.
//

import Foundation
import FlutterModuleInterfaces
import Flutter

public class FlutterModule: FlutterModuleProtocol {
    private var engines: FlutterEngineGroup?
    
    public init() {
        engines = FlutterEngineGroup(name: "flutter-module", project: nil)
    }
    
    public func getViewController(entrypoint: String, for bundle: Bundle) -> UIViewController {
        let dartProject = FlutterDartProject(precompiledDartBundle: bundle)
//        let newEngine = engines?.makeEngine(withEntrypoint: entrypoint, libraryURI: nil, initialRoute: nil)
        let controller = FlutterViewController(project: dartProject, initialRoute: "", nibName: nil, bundle: bundle)
        return controller
    }
}
