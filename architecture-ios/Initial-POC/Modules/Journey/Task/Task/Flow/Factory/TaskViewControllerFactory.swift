//
//  TaskViewControllerFactory.swift
//  Task
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import Core
import UIKit
import FlutterManagerInterfaces

public class TaskViewControllerFactory {
    let flutterManager: FlutterManagerProtocol
    
    init(flutterManager: FlutterManagerProtocol) {
        self.flutterManager = flutterManager
    }
    
    func makeTaskViewController(isIndex: Bool = false) -> UIViewController {
        return flutterManager.getViewController(from: Bundle(for: Self.self))
    }
}
