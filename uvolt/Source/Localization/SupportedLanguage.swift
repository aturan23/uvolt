//
//  SupportedLanguage.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation

enum SupportedLanguage: String, Codable {
    
    case ru
    case en
    
    static var all: [SupportedLanguage] {
        return [.ru, .en]
    }
}

extension SupportedLanguage {
    
    static func defineCurrentLanguage() -> SupportedLanguage {
        if let currentLanguageSetting = UserDefaults.standard.string(forKey: GlobalConstants.UserDefaultsKeys.currentLanguage),
            let supportedLanguage = SupportedLanguage(rawValue: currentLanguageSetting) {
            return supportedLanguage
        }
        
        if let currentLocale = Locale.current.languageCode?.lowercased(),
            let supportedLanguge = SupportedLanguage(rawValue: currentLocale) {
            return supportedLanguge
        }
        
        return GlobalConstants.Localization.defaultLanguage
    }
    
    var localizedTitle: String {
        switch self {
        case .ru:
            return "Русский"
        case .en:
            return "English"
        }
    }
    
    var locale: Locale {
        switch self {
        case .en:
            return Locale(identifier: "en_US")
        case .ru:
            return Locale(identifier: "ru_RU")
        }
    }
}
