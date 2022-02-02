//
//  NoteViewControllerFactory.swift
//  Note
//
//  Created by Ailton Vieira Pinto Filho on 01/02/22.
//

import Core
import UIKit
import FlutterManagerInterfaces

public class NoteViewControllerFactory {
    let flutterManager: FlutterManagerProtocol
    
    init(flutterManager: FlutterManagerProtocol) {
        self.flutterManager = flutterManager
    }
    
    func makeNoteViewController(isIndex: Bool = false) -> UIViewController {
        return flutterManager.getViewController(from: Bundle(for: Self.self))
    }
}
