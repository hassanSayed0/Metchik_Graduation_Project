//
//  AppRouter.swift
//  Metchik
//
//  Created by Hassan on 05/03/2024.
//

import UIKit

public final class AppRouter {
    public let navigationController: UINavigationController
    
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.backIndicatorImage = UIImage(asset: Asset.Icons.arrow)?
            .withRenderingMode(.alwaysOriginal)
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = UIImage(asset: Asset.Icons.arrow)?
            .withRenderingMode(.alwaysOriginal)
    }
}

extension AppRouter: Router {
    public func present(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    public func presentFullScreen(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: animated, completion: completion)
    }
    
    public func presentOverFullScreen(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: animated, completion: completion)
    }
    
    public func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated, completion: completion)
        } else {
            navigationController.popViewController(animated: animated)
            completion()
        }
    }
    
    public func push(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        viewController.navigationItem.backButtonTitle = ""
        navigationController.dismiss(animated: false)
        navigationController.pushViewController(viewController, animated: animated)
        completion()
    }
    
    public func reset(completion: @escaping () -> Void) {
        if !self.navigationController.viewControllers.isEmpty {
            navigationController.dismiss(animated: false)
            navigationController.viewControllers.removeAll()
            completion()
        }
    }
    
    public func popToViewController(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        navigationController.popToViewController(viewController, animated: animated)
        completion()
    }
    
    public func popToRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.popToRootViewController(animated: animated)
        completion()
    }
}
