//
//  PreloadViewProtocols.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

protocol PreloadViewInput: class {
    func display(viewAdapter: PreloadViewAdapter)
}

protocol PreloadViewOutput {
    func didLoad()
}
