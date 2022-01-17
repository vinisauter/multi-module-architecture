//
//  BaseProvider.swift
//  Core
//
//  Created by ACT on 22/12/21.
//

import Foundation

public protocol BaseProvider {
    associatedtype TypeOfProvider
    var provider: TypeOfProvider { get set }
    init(typeProvider:TypeOfProvider)
}

open class Provider<Provider>: BaseProvider {
    public var provider: Provider.Type
    
    public required init(typeProvider: Provider.Type) {
        self.provider = typeProvider
    }
    
}
