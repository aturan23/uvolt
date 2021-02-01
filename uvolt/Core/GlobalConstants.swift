//
//  GlobalConstants.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation

enum GlobalConstants {
    
    enum UserDefaultsKeys {
        static let currentLanguage = "currentLanguage"
    }
    
    enum Localization {
        static let defaultLanguage: SupportedLanguage = .ru
        static let localizationFileExtension = ".json"
        static let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    }

}
