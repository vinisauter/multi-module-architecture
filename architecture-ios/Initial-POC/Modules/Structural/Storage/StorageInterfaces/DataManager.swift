//
//  DataManager.swift
//  StorageInterfaces
//
//  Created by Felippe Matos on 17/11/21.
//

import Foundation

public protocol DataManagerProtocol {
    func saveLastJourneyOpened(journey: String)
    func getLastJourneyOpened() -> String
}
