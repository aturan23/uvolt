//
//  ConnectViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

class ConnectViewModel: ConnectViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: ConnectViewInput?
    var router: ConnectRouterInput?
    weak var moduleOutput: ConnectModuleOutput?

    // ------------------------------
    // MARK: - ConnectViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: ConnectViewAdapter())
    }
}

// ------------------------------
// MARK: - ConnectModuleInput methods
// ------------------------------

extension ConnectViewModel: ConnectModuleInput {
    func configure(data: ConnectConfigData) { }
}
