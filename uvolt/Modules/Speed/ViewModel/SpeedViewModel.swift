//
//  SpeedViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class SpeedViewModel: SpeedViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SpeedViewInput?
    var router: SpeedRouterInput?
    weak var moduleOutput: SpeedModuleOutput?

    // ------------------------------
    // MARK: - SpeedViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SpeedViewAdapter())
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
}

// ------------------------------
// MARK: - SpeedModuleInput methods
// ------------------------------

extension SpeedViewModel: SpeedModuleInput {
    func configure(data: SpeedConfigData) { }
}
