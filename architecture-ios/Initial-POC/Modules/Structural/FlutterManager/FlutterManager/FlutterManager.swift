//
//  FlutterManager.swift
//  FlutterManager
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import FlutterManagerInterfaces
import Flutter

public class FlutterManager: FlutterManagerProtocol {
    
    public init() {}
    
    public func attach(from bundle: Bundle,
                       in containerView: UIView,
                       parentController: UIViewController,
                       completion: @escaping (Bool) -> Void) {
        let controller = FlutterManagerViewController(from: bundle)
        
        parentController.addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.frame = containerView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParent: parentController)
        
        controller.setFlutterViewDidRenderCallback {
            completion(true)
        }
    }
}
