//
//  PreloadAssembly.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

typealias PreloadConfiguration = (PreloadModuleInput) -> PreloadModuleOutput?

final class PreloadModuleAssembly: BaseModuleAssembly {
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: PreloadConfiguration? = nil) -> BaseViewController {
        let viewController = PreloadViewController()
        let router = PreloadRouter(connectModuleAssembly: injection.inject(ConnectModuleAssembly.self))
        let viewModel = PreloadViewModel()
        viewModel.view = viewController
        viewModel.router = router
        router.viewController = viewController
        viewController.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
