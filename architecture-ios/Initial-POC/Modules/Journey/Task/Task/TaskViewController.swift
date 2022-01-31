//
//  TaskViewController.swift
//  Task
//
//  Created by Ailton Vieira Pinto Filho on 31/01/22.
//

import UIKit

class TaskViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
