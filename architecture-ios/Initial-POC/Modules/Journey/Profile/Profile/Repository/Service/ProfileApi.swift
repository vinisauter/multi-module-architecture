//
//  ProfileApi.swift
//  Profile
//
//  Created by Felippe Matos on 10/11/21.
//

import Foundation

protocol ProfileApiProtocol {
    func getUserName() -> String
}

class ProfileApi: ProfileApiProtocol {
    func getUserName() -> String {
        return "The One"
    }
}
