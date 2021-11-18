//
//  ProfileBusinessModel.swift
//  Profile
//
//  Created by Felippe Matos on 10/11/21.
//

import Foundation

protocol ProfileBusinessProtocol {
    func getUserName() -> String
}

class ProfileBusinessModel: ProfileBusinessProtocol {
    let repository: ProfileApiProtocol = ProfileApi()
    
    func getUserName() -> String {
        return repository.getUserName()
    }
}
