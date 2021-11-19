//
//  ProfileLauncher.swift
//  Profile
//
//  Created by Felippe Matos on 09/11/21.
//

import UIKit

enum Screens: String {
    case EditProfile = "editProfile"
}

public protocol ProfileNavigationDelegate: AnyObject {
    func returnToLoginByProfile()
}

public protocol ProfileNavigationProtocol: AnyObject {
    func start(delegate: ProfileNavigationDelegate?, deepLinkParameters: [String: String]?) -> UIViewController
    func finish(delegate: ProfileNavigationDelegate?)
}

open class ProfileLauncher: ProfileNavigationProtocol {
    static let shared: ProfileLauncher = ProfileLauncher()
    
    var businessModel: ProfileBusinessProtocol = ProfileBusinessModel()
    
    public init() {}
    
    public func start(delegate: ProfileNavigationDelegate?, deepLinkParameters: [String: String]?) -> UIViewController {
        let deepLink = deepLinkParameters?.first?.value
        
        switch deepLink {
        case Screens.EditProfile.rawValue:
            let viewModel = EditProfileViewModel(businessModel: ProfileLauncher.shared.businessModel)
            return EditProfileViewController(viewModel: viewModel)
        default:
            let viewModel = ProfileViewModel(businessModel: ProfileLauncher.shared.businessModel)
            return ProfileViewController(viewModel: viewModel, delegate: delegate)
        }
    }
    
    public func finish(delegate: ProfileNavigationDelegate?) {
        delegate?.returnToLoginByProfile()
    }
}
