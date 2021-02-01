//
//  UIFontExtension.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

extension UIFont {
    static func regular(size: CGFloat) -> UIFont {
        // Here your custom font
//        guard let font = UIFont(name: "FONT-Regular", size: size) else {
//            return .systemFont(ofSize: size, weight: .regular)
//        }
//        return font
        
        return .systemFont(ofSize: size, weight: .regular)
    }
    
    static func semibold(size: CGFloat) -> UIFont {
        // Here your custom font
//        guard let font = UIFont(name: "FONT-Semibold", size: size) else {
//            return .systemFont(ofSize: size, weight: .semibold)
//        }
//        return font
        
        return .systemFont(ofSize: size, weight: .semibold)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        // Here your custom font
//        guard let font = UIFont(name: "FONT-Bold", size: size) else {
//            return .systemFont(ofSize: size, weight: .bold)
//        }
//        return font
        
        return .systemFont(ofSize: size, weight: .bold)
    }
}
