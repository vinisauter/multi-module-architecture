//
//  ProfileLauncher.swift
//  Profile
//
//  Created by Felippe Matos on 09/11/21.
//

import UIKit 

public protocol ProfileNavigationDelegate: AnyObject {
    func returnToLoginByProfile()
}

public protocol ProfileNavigationProtocol: AnyObject {
    func start(delegate: ProfileNavigationDelegate?) -> UIViewController
    func finish(delegate: ProfileNavigationDelegate?)
}

open class ProfileLauncher: ProfileNavigationProtocol {
    static let shared: ProfileLauncher = ProfileLauncher()
    
    var businessModel: ProfileBusinessProtocol = ProfileBusinessModel()
    
    public init() {}
    
    public func start(delegate: ProfileNavigationDelegate?) -> UIViewController {
        let viewModel = ProfileViewModel(businessModel: ProfileLauncher.shared.businessModel)
        return ProfileViewController(viewModel: viewModel, delegate: delegate)
    }
    
    public func finish(delegate: ProfileNavigationDelegate?) {
        delegate?.returnToLoginByProfile()
    }
}
