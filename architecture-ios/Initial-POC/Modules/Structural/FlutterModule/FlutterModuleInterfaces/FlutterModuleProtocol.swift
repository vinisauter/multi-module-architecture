//
//  FlutterModuleProtocol.swift
//  FlutterModuleInterfaces
//
//  Created by Ailton Vieira Pinto Filho on 18/01/22.
//

import Foundation
import UIKit

public protocol FlutterModuleProtocol {
    func getViewController(entrypoint: String, for bundle: Bundle) -> UIViewController
}
