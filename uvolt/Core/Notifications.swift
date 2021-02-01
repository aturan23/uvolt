//
//  Notifications.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation

enum UvoltNotifications: String {
    case languageDidChange
    
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
}
