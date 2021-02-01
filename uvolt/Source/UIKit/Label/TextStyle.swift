//
//  TextStyle.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation
import UIKit

public enum TextStyle {
    /// Heading / H1 - 32 Semibold
    case headingH1
    
    /// Heading / H2 - 24 Semibold
    case headingH2
    
    /// Heading / H5 - 17 Semibold
    case headingH5
    
    /// Paragraph / Body - 15 Semibold
    case paragraphBody
    
    /// Paragraph / Secondary - 15 Regular
    case paragraphSecondary
    
    /// Paragraph / Caption - 13 Regular
    case paragraphCaption
    
    /// Paragraph / CAPTION CAPS - 13 Semibold
    case paragraphCaptionCaps
    
    /// Menu / Small Helper Text - 12 Reg
    case smallHelper
    
    var lineSpacing: CGFloat {
        switch self {
        case .headingH2:
            return 3.25
        case .headingH5:
            return 2.2
        case .paragraphBody, .paragraphSecondary, .paragraphCaption:
            return 4
        default:
            return 0
        }
    }
    
    var kern: CGFloat {
        switch self {
        case .headingH1, .headingH2, .headingH5:
            return 0.2
        case .paragraphBody, .smallHelper:
            return 0.3
        case .paragraphSecondary:
            return 0.4
        case .paragraphCaption:
            return 0.5
        case .paragraphCaptionCaps:
            return 0.6
        }
    }
    
    var font: UIFont {
        switch self {
        case .headingH1:
            return .semibold(size: 32)
        case .headingH2:
            return .semibold(size: 24)
        case .headingH5:
            return .semibold(size: 17)
        case .paragraphBody:
            return .semibold(size: 15)
        case .paragraphSecondary:
            return .regular(size: 15)
        case .paragraphCaption:
            return .regular(size: 13)
        case .smallHelper:
            return .regular(size: 12)
        case .paragraphCaptionCaps:
            return .semibold(size: 13)
        }
    }
}
