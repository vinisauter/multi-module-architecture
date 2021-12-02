//
//  UIViewController+Extensions.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public extension UIViewController {
    static func instantiateViewController<T: UIViewController>(ofType type: T.Type, in storyboardName: String = "Main") -> T? {
        let identifier = String(describing: type.self)
        return UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? T
    }
    
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    func popToViewController<T: UIViewController>(_ type: T.Type) {
        navigationController?.popToViewControllerWithType(type)
    }
    
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
