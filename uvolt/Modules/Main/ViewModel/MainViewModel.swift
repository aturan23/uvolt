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
        fetchInformation()
    }
    
    func showSettingsPage() {
        router?.routeToSettings()
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func fetchInformation() {
        let types: [InformationType] = [.avgSpeed(num: 23.2),
                                        .calories(num: 35),
                                        .distance(num: 1.0),
                                        .odo(num: 58.9),
                                        .avgPower(power: 187.9, wat: 93.4),
                                        .fuel(num: 0.1)]
        view?.display(viewAdapter: MainViewAdapter(
                        frame: .frame(num: "10000"),
                        charge: .charge(num: 50),
                        otherTypes: types))
    }
}

// ------------------------------
// MARK: - MainModuleInput methods
// ------------------------------

extension MainViewModel: MainModuleInput {
    func configure(data: MainConfigData) { }
}
