//
//  DependencyProvider.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import Networking
import Storage

class DependencyProvider {
    static var networking: Networking = {
        return Networking()
    }()
    
    static var storage: String = {
        return "Módulo de Storage"
    }()
}
