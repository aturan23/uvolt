//
//  ConnectViewProtocols.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

protocol ConnectViewInput: class {
    func display(viewAdapter: ConnectViewAdapter)
}

protocol ConnectViewOutput {
    func didLoad()
    func showMainPage()
    func didSelect(device: DeviceModel?)
}
