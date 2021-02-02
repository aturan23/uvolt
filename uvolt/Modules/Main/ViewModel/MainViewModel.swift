//
//  MainViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class MainViewModel: MainViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: MainViewInput?
    var router: MainRouterInput?
    weak var moduleOutput: MainModuleOutput?

    // ------------------------------
    // MARK: - MainViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: MainViewAdapter())
    }
    
    func showSettingsPage() {
        router?.routeToSettings()
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
}

// ------------------------------
// MARK: - MainModuleInput methods
// ------------------------------

extension MainViewModel: MainModuleInput {
    func configure(data: MainConfigData) { }
}
