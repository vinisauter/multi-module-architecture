//
//  FlutterModuleViewController.swift
//  FlutterModule
//
//  Created by Ailton Vieira Pinto Filho on 19/01/22.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class FlutterModuleViewController: FlutterViewController {
    var counter = 0
    
    convenience init(from bundle: Bundle, initialRoute: String? = nil) {
        let project = FlutterDartProject(precompiledDartBundle: bundle)
        let engine = FlutterEngine(name: "name", project: project)
        engine.run(withEntrypoint: nil, initialRoute: initialRoute)
        self.init(from: engine)
    }
    
    convenience init(from engineGroup: FlutterEngineGroup, entrypoint: String? = nil, initialRoute: String? = nil) {
        let engine = engineGroup.makeEngine(withEntrypoint: nil, libraryURI: nil, initialRoute: initialRoute)
        self.init(from: engine)
    }
    
    private init(from engine: FlutterEngine) {
        GeneratedPluginRegistrant.register(with: engine)
        super.init(engine: engine, nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let close = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction { _ in
            let newVC = FlutterModule.shared.getViewController(entrypoint: "", in: Bundle(for: Self.self))
            self.navigationController?.pushViewController(newVC, animated: true)
        }, menu: nil)

        navigationItem.rightBarButtonItems = [close]
        
//        let channel = FlutterMethodChannel(name: "multiple-flutters", binaryMessenger: engine!.binaryMessenger)
//        
//        channel.setMethodCallHandler({ (call, result) in
//            if call.method == "incrementCount" {
//                self.counter += 1
//                channel.invokeMethod("setCount", arguments: self.counter)
//                result(nil)
//            }
//        })
    }
    
    private func detach() {
        self.engine?.viewController = nil
        self.engine?.destroyContext()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            self.detach()
        }
    }
    
    func destroy() {
    }
}
