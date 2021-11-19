//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Felippe Matos on 10/11/21.
//

import Foundation

protocol ProfileViewModelProtocol {
    var businessModel: ProfileBusinessProtocol { get set }
    func getUserName() -> String
}

class ProfileViewModel: ProfileViewModelProtocol {
    var businessModel: ProfileBusinessProtocol
    
    var userName: String = ""
    
    public init(businessModel: ProfileBusinessProtocol) {
        self.businessModel = businessModel
    }
    
    func getUserName() -> String {
        userName = businessModel.getUserName()
        return userName
    }
}
