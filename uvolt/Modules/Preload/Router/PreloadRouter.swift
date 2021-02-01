//
//  PreloadRouter.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class PreloadRouter: PreloadRouterInput {
	weak var viewController: BaseViewController?
    private let connectModuleAssembly: ConnectModuleAssembly?
    
    init(connectModuleAssembly: ConnectModuleAssembly?) {
        self.connectModuleAssembly = connectModuleAssembly
    }
    
    // ------------------------------
    // MARK: - PreloadRouterInput methods
    // ------------------------------
    
    func routeToConnect() {
        guard let controller = connectModuleAssembly?.assemble() else { return }
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
