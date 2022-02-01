//
//  FlutterManagerProtocol.swift
//  FlutterManagerInterfaces
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import Foundation
import UIKit

public protocol FlutterManagerProtocol {    
    func attach(from bundle: Bundle,
                in containerView: UIView,
                parentController: UIViewController,
                completion: @escaping (Bool) -> Void)
}

public extension FlutterManagerProtocol {
    func getViewController(from bundle: Bundle) -> UIViewController {
        return FlutterBaseViewController(from: bundle, flutterManager: self)
    }
}
