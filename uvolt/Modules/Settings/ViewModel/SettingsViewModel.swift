//
//  SettingsViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class SettingsViewModel: SettingsViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SettingsViewInput?
    var router: SettingsRouterInput?
    weak var moduleOutput: SettingsModuleOutput?

    // ------------------------------
    // MARK: - SettingsViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SettingsViewAdapter())
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
}

// ------------------------------
// MARK: - SettingsModuleInput methods
// ------------------------------

extension SettingsViewModel: SettingsModuleInput {
    func configure(data: SettingsConfigData) { }
}
