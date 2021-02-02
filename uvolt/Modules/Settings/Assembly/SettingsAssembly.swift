//
//  SettingsAssembly.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

typealias SettingsConfiguration = (SettingsModuleInput) -> SettingsModuleOutput?

final class SettingsModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: SettingsConfiguration? = nil) -> BaseViewController {
        let viewController = SettingsViewController()
        let router = SettingsRouter()
        let viewModel = SettingsViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
