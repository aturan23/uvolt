//
//  MainRouter.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class MainRouter: MainRouterInput {
    
	weak var viewController: BaseViewController?
    private let settingsModuleAssembly: SettingsModuleAssembly?
    
    init(settingsModuleAssembly: SettingsModuleAssembly?) {
        self.settingsModuleAssembly = settingsModuleAssembly
    }

	// ------------------------------
    // MARK: - MainRouterInput methods
    // ------------------------------

    func routeToSettings() {
        guard let controller = settingsModuleAssembly?.assemble() else { return }
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
