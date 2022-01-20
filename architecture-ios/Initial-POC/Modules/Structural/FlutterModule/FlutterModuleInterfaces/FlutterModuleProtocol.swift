//
//  FlutterModuleProtocol.swift
//  FlutterModuleInterfaces
//
//  Created by Ailton Vieira Pinto Filho on 18/01/22.
//

import Foundation
import UIKit

public protocol FlutterModuleProtocol: AnyObject {
    func getViewController(entrypoint: String, in bundle: Bundle) -> UIViewController
}
