//
//  SettingsViewAdapter.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

/// Default ViewModel passed to View layer for displaying
import CoreData

struct SettingsViewAdapter: Codable {
    var items: [SettingItem]
    
    func toJSON() -> String? {
        do {
            let jsonData = try JSONEncoder().encode(items)
            return String(data: jsonData, encoding: .utf8)
        } catch let error {
            print("error converting to json: \(error)")
            return nil
        }
    }

}

struct SettingItem: Codable {
    var type: SettingFrameType
    var value: String? = nil
}
