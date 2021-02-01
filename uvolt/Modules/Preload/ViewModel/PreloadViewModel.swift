//
//  PreloadViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import Foundation

class PreloadViewModel: PreloadViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: PreloadViewInput?
    var router: PreloadRouterInput?
    weak var moduleOutput: PreloadModuleOutput?

    // ------------------------------
    // MARK: - PreloadViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: PreloadViewAdapter())
    }
    
    func showConnectPage() {
        router?.routeToConnect()
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
}

// ------------------------------
// MARK: - PreloadModuleInput methods
// ------------------------------

extension PreloadViewModel: PreloadModuleInput {
    func configure(data: PreloadConfigData) { }
}
