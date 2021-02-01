//
//  ConnectModuleInput.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Adapter struct for Connect initial configuration 
/// through ConnectModuleInput
struct ConnectConfigData { }

/// Protocol with public methods to configure Connect 
/// from its parent module (usually implemented by this module's ViewModel)
protocol ConnectModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: ConnectConfigData)
}
