//
//  UINavigationController+Extensions.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit

public extension UINavigationController {
    @discardableResult func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> [UIViewController]? {
        for viewController in self.viewControllers {
            if viewController is T {
                return self.popToViewController(viewController, animated: true)
            }
        }
        return nil
    }
}
