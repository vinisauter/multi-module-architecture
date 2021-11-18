//
//  HomeApi.swift
//  Home
//
//  Created by Felippe Matos on 16/11/21.
//

import Foundation

protocol HomeApiProtocol {
    func getUserName() -> String
}

class HomeApi: HomeApiProtocol {
    func getUserName() -> String {
        return "The One"
    }
}
