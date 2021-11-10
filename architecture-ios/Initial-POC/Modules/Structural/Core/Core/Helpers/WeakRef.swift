//
//  WeakRef.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

final class WeakRef<T: AnyObject> {
    private(set) weak var value: T?
    
    init(_ value: T) {
        self.value = value
    }
}
