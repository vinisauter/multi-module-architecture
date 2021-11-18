//
//  HomeLauncher.swift
//  Home
//
//  Created by Felippe Matos on 16/11/21.
//

import UIKit

public enum Journey {
    case Login
    case Profile
}

public protocol HomeNavigationDelegate: AnyObject {
    func goToProfileByHome()
    func returnToLoginByHome()
}

public protocol HomeNavigationProtocol: AnyObject {
    func start(delegate: HomeNavigationDelegate?) -> UIViewController
    func finish(start newJourney: Journey, delegate: HomeNavigationDelegate?)
}

open class HomeLauncher: HomeNavigationProtocol {
    static let shared: HomeLauncher = HomeLauncher()
    
    var businessModel: HomeBusinessProtocol = HomeBusinessModel()
    
    public init() {}
    
    public func start(delegate: HomeNavigationDelegate?) -> UIViewController {
        let viewModel = HomeViewModel(businessModel: HomeLauncher.shared.businessModel)
        return HomeViewController(viewModel: viewModel, delegate: delegate)
    }
    
    public func finish(start newJourney: Journey, delegate: HomeNavigationDelegate?) {
        switch newJourney {
        case .Profile:
            delegate?.goToProfileByHome()
        case .Login:
            delegate?.returnToLoginByHome()
        }
    }
}
