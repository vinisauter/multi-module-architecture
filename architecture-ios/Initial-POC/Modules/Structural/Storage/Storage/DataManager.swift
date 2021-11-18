//
//  DataManager.swift
//  Storage
//
//  Created by Felippe Matos on 17/11/21.
//

import Foundation
import StorageInterfaces

open class DataManager: DataManagerProtocol {
    let defaults = UserDefaults.standard
    
    public init() {}
    
    public func saveLastJourneyOpened(journey: String) {
        defaults.set(journey, forKey: "lastJourneyOpened")
        defaults.synchronize()
    }
    
    public func getLastJourneyOpened() -> String {
        guard let lastJourney = defaults.object(forKey: "lastJourneyOpened") as? String else { return "" }
        return lastJourney
    }
}
