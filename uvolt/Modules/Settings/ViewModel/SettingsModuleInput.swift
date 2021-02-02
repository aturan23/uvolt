//
//  SettingsModuleInput.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Adapter struct for Settings initial configuration 
/// through SettingsModuleInput
struct SettingsConfigData { }

/// Protocol with public methods to configure Settings 
/// from its parent module (usually implemented by this module's ViewModel)
protocol SettingsModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: SettingsConfigData)
}
