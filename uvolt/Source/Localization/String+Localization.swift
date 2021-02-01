//
//  String+Localization.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation

extension String {
    
    func localized(up: Bool = false) -> String {
        let localizer = Inject.depContainer.inject(LocalLocalizer.self)!
        let localized = localizer.getLocalization(for: self)
        return up ? localized.uppercased() : localized
    }
    
}
