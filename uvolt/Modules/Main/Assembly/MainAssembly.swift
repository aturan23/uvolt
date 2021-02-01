//
//  MainAssembly.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

typealias MainConfiguration = (MainModuleInput) -> MainModuleOutput?

final class MainModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: MainConfiguration? = nil) -> BaseViewController {
        let viewController = MainViewController()
        let router = MainRouter()
        let viewModel = MainViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
