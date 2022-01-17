//
//  InjectProviders.swift
//  Core
//
//  Created by ACT on 22/12/21.
//

import Foundation

open class InjectProviders{
    
    private static var providers: Dictionary<String,AnyObject> = [:]
    private static var providersInject: Dictionary<String,Provider<AnyObject>> = [:]
    
    public init(){}
    
    public static func addProvider(name:String,ob:AnyObject){
        InjectProviders.providers[name] = ob
    }
    
    public static func get<T>(name:String) -> T{
        return InjectProviders.providers[name] as! T
    }
    
    public func get<T>(name:String,to ofType:T.Type) -> T{
        return InjectProviders.providers[name] as! T
    }
    
    
}
