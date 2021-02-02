//
//  MainViewProtocols.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

protocol MainViewInput: class {
    func display(viewAdapter: MainViewAdapter)
}

protocol MainViewOutput {
    func didLoad()
    func showSettingsPage()
}
