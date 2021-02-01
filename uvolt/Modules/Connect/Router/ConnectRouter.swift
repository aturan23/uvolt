//
//  ConnectRouter.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class ConnectRouter: ConnectRouterInput {
    
	weak var viewController: BaseViewController?
    private let mainModuleAssembly: MainModuleAssembly?
    
    init(mainModuleAssembly: MainModuleAssembly?) {
        self.mainModuleAssembly = mainModuleAssembly
    }
    
    // ------------------------------
    // MARK: - ConnectRouterInput methods
    // ------------------------------
    
    func routeToMain() {
        guard let controller = mainModuleAssembly?.assemble() else { return }
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
