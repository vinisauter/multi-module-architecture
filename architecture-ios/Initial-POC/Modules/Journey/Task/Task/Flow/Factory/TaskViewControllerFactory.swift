//
//  TaskViewControllerFactory.swift
//  Task
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import Core
import UIKit

public class TaskViewControllerFactory {
    
    init() {
    }
    
    func makeTaskViewController(isIndex: Bool = false) -> UIViewController {
        return TaskViewController()
    }
}
