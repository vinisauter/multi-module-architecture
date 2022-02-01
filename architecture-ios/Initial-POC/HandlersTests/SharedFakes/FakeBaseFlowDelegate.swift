//
//  MockBaseFlowDelegate.swift
//  HandlersTests
//
//  Created by Nykolas Mayko Maia Barbosa on 27/01/22.
//

import UIKit
import Core

class FakeBaseFlowDelegate: BaseFlowDelegate {
    func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?) {}
}
