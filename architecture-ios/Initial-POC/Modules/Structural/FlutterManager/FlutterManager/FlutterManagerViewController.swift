//
//  FlutterManagerViewController.swift
//  FlutterManager
//
//  Created by Ailton Vieira Pinto Filho on 01/02/22.
//

import UIKit
import Flutter
//import FlutterPluginRegistrant

class FlutterManagerViewController: FlutterViewController {
    
    convenience init(from bundle: Bundle, initialRoute: String? = nil) {
        let project = FlutterDartProject(precompiledDartBundle: bundle)
        let engine = FlutterEngine(name: "name", project: project)
        engine.run(withEntrypoint: nil, initialRoute: initialRoute)
        self.init(from: engine)
    }
    
    convenience init(from engineGroup: FlutterEngineGroup, entrypoint: String? = nil, initialRoute: String? = nil) {
        let engine = engineGroup.makeEngine(withEntrypoint: entrypoint, libraryURI: nil, initialRoute: initialRoute)
        self.init(from: engine)
    }
    
    private init(from engine: FlutterEngine) {
//        GeneratedPluginRegistrant.register(with: engine)
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
        }, menu: nil)

        navigationItem.rightBarButtonItems = [close]
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
