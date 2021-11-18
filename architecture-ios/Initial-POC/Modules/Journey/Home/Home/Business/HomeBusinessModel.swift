//
//  HomeBusinessModel.swift
//  Home
//
//  Created by Felippe Matos on 16/11/21.
//

import Foundation

protocol HomeBusinessProtocol {
    func getUserName() -> String
}

class HomeBusinessModel: HomeBusinessProtocol {
    let repository: HomeApiProtocol = HomeApi()
    
    func getUserName() -> String {
        return repository.getUserName()
    }
}
