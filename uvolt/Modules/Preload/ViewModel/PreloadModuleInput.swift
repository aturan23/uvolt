//
//  PreloadModuleInput.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Adapter struct for Preload initial configuration 
/// through PreloadModuleInput
struct PreloadConfigData { }

/// Protocol with public methods to configure Preload 
/// from its parent module (usually implemented by this module's ViewModel)
protocol PreloadModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: PreloadConfigData)
}
