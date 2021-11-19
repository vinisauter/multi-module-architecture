//
//  EditProfileViewModel.swift
//  Profile
//
//  Created by Felippe Matos on 18/11/21.
//

import Foundation

protocol EditProfileViewModelProtocol {
    func save() -> String
}

class EditProfileViewModel:EditProfileViewModelProtocol {
    let businessModel: ProfileBusinessProtocol
    
    public init(businessModel: ProfileBusinessProtocol) {
        self.businessModel = businessModel
    }
    
    func save() -> String {
        return "Dados salvos"
    }
}
