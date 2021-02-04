//
//  SpeedModuleInput.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Adapter struct for Speed initial configuration 
/// through SpeedModuleInput
struct SpeedConfigData { }

/// Protocol with public methods to configure Speed 
/// from its parent module (usually implemented by this module's ViewModel)
protocol SpeedModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: SpeedConfigData)
}
