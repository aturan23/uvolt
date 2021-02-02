//
//  SettingsViewProtocols.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

protocol SettingsViewInput: class {
    func display(viewAdapter: SettingsViewAdapter)
}

protocol SettingsViewOutput {
    func didLoad()
}
