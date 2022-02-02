//
//  NoteViewController.swift
//  Note
//
//  Created by Ailton Vieira Pinto Filho on 01/02/22.
//

import UIKit

class NoteViewController: UIViewController {
    
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
