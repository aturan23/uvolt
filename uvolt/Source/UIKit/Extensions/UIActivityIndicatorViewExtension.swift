//
//  UIActivityIndicatorViewExtension.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView: IndicatorProtocol {
    public var radius: CGFloat {
        get {
            return frame.width / 2
        }
        set {
            frame.size = CGSize(width: 2 * newValue, height: 2 * newValue)
            setNeedsDisplay()
        }
    }
    
    public var color: UIColor {
        get {
            return tintColor
        }
        set {
            tintColor = newValue
        }
    }
    // unused
    public func setupAnimation(in layer: CALayer, size: CGSize) {}
}
