//
//  AppNavigation.swift
//  App
//
//  Created by Felippe Matos on 10/11/21.
//

import UIKit
import Storage
import Login
import Home
import Profile

enum Journey: String {
    case Login = "Login"
    case Home = "Home"
    case Profile = "Profile"
}

class AppNavigation {
    static let shared: AppNavigation = AppNavigation()
    var navigationController: UINavigationController = UINavigationController()
    
    let storage = DataManager()
    
    func setRootViewController(by journey: Journey) {
        self.navigationController.setViewControllers([AppNavigation().setJourney(by: .Login)], animated: false)
    }
    
    func setJourney(by journey: Journey) -> UIViewController {
        switch journey {
        case .Login:
            return LoginLauncher().start(delegate: AppNavigation.shared)
        case .Home:
            return HomeLauncher().start(delegate: AppNavigation.shared)
        case .Profile:
            return ProfileLauncher().start(delegate: AppNavigation.shared)
        }
    }
}

// MARK: Login Navigation
extension AppNavigation: LoginNavigationDelegate {
    func goToJourneyByLogin() {
        let lastJourney = storage.getLastJourneyOpened()
        
        switch lastJourney {
        case Journey.Profile.rawValue:
            self.navigationController.pushViewController(AppNavigation().setJourney(by: .Profile), animated: false)
        default:
            self.navigationController.pushViewController(AppNavigation().setJourney(by: .Home), animated: false)
        }
    }
}

// MARK: Home Navigation
extension AppNavigation: HomeNavigationDelegate {
    func goToProfileByHome() {
        self.navigationController.pushViewController(AppNavigation().setJourney(by: .Profile), animated: false)
    }
    
    func returnToLoginByHome() {
        storage.saveLastJourneyOpened(journey: "Home")
        returnToLogin()
    }
}

// MARK: Profile Navigation
extension AppNavigation: ProfileNavigationDelegate {
    func returnToLoginByProfile() {
        storage.saveLastJourneyOpened(journey: "Profile")
        returnToLogin()
    }
}

// MARK: General Navigation
extension AppNavigation {
    func returnToLogin() {
        if let destinationViewController = navigationController.viewControllers.filter({$0 is LoginViewController}).first {
            navigationController.popToViewController(destinationViewController, animated: true)
        }
    }
}
