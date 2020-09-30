//
//  UIViewController+Extensions.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 28.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var isModal: Bool {
        return navigationController?.presentingViewController != nil
    }

    var rootController: UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }
    
    var topController: UIViewController? {
        return topViewController(from: rootController)
    }
    
    func topViewController(from viewController: UIViewController?) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
    
}
