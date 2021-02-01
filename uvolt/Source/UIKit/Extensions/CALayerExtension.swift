//
//  CALayerExtension.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

extension CALayer {
    static func makeShadowed(
        color: UIColor = .black,
        alpha: Float = 1,
        offset: CGSize = .zero,
        radius: CGFloat = 4,
        rect: CGRect,
        cornerRadius: CGFloat = 0
    ) -> CALayer {
        let layer = CALayer()
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        layer.masksToBounds = false
        return layer
    }
}
