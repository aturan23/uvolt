//
//  MainModuleInput.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Adapter struct for Main initial configuration 
/// through MainModuleInput
struct MainConfigData { }

/// Protocol with public methods to configure Main 
/// from its parent module (usually implemented by this module's ViewModel)
protocol MainModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: MainConfigData)
}
