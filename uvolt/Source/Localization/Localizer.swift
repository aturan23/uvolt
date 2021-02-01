//
//  Localizer.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation

protocol LocalizerType {
    var currentLanguage: SupportedLanguage { get }
    func getLocalization(for key: String) -> String
    func changeLanguage(_ language: SupportedLanguage)
}
