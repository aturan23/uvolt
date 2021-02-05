//
//  SettingsViewAdapter.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Default ViewModel passed to View layer for displaying
import CoreData

struct SettingsViewAdapter {
    var items: [SettingItem]
    
}

struct SettingItem {
    var type: SettingFrameType
    var value: Any? = nil
}
