//
//  HomeViewModel.swift
//  Home
//
//  Created by Felippe Matos on 16/11/21.
//

import Foundation

protocol HomeViewModelProtocol {
    var businessModel: HomeBusinessProtocol { get set }
    func getUserName() -> String
}

class HomeViewModel: HomeViewModelProtocol {
    var businessModel: HomeBusinessProtocol
    
    public init(businessModel: HomeBusinessProtocol) {
        self.businessModel = businessModel
    }
    
    func getUserName() -> String {
        return self.businessModel.getUserName()
    }
}

