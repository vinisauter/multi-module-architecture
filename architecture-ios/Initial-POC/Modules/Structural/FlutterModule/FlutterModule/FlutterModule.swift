//
//  FlutterModule.swift
//  FlutterModule
//
//  Created by Ailton Vieira Pinto Filho on 18/01/22.
//

import Foundation
import FlutterModuleInterfaces
import Flutter
import FlutterPluginRegistrant

public class FlutterModule: FlutterModuleProtocol {
    public static let shared = FlutterModule()
    
    var engines: FlutterEngineGroup!
    
    private let useGroup: Bool = false
    
    public init() {
        if useGroup {
//            engines = FlutterEngineGroup(name: "flutter-module", project: FlutterDartProject(precompiledDartBundle: Bundle(for: Self.self)))
        }
    }
    
    public func getViewController(entrypoint: String, in bundle: Bundle) -> UIViewController {
        let controller: FlutterModuleViewController
//        let engine: FlutterEngine
        if useGroup {
            if engines == nil {
                engines = FlutterEngineGroup(name: "flutter-module", project: FlutterDartProject(precompiledDartBundle: bundle))
            }
            controller = FlutterModuleViewController(from: engines, entrypoint: entrypoint)
        } else {
            controller = FlutterModuleViewController(from: bundle)
        }
        return controller
    }
}
