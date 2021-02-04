//
//  SpeedViewProtocols.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

protocol SpeedViewInput: class {
    func display(viewAdapter: SpeedViewAdapter)
}

protocol SpeedViewOutput {
    func didLoad()
}
