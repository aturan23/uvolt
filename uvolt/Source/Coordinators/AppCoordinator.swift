//
//  AppCoordinator.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class AppCoordinator: AppCoordinating {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let injection: ModuleInjecting
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(window: UIWindow, injection: ModuleInjecting) {
        self.window = window
        self.injection = injection
        navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .clear
        navigationController.navigationBar.isTranslucent = false
    }
    
    // MARK: - RegistrationCoordinating
    
    func start() {
        guard
            let registrationViewController = injection
                .inject(PreloadModuleAssembly.self)?
                .assemble()
            else {
                return
        }
        navigationController.setViewControllers([registrationViewController], animated: false)
        
        let transition: () -> Void = { self.window.rootViewController = self.navigationController }
        if let previousViewController = window.rootViewController {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: transition)
            previousViewController.dismiss(animated: false) {
                previousViewController.view.removeFromSuperview()
            }
        } else {
            transition()
        }
    }
}
