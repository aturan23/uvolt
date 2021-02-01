//
//  UIButtonExtension.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

extension UIButton {
    static var allControlStates: [UIControl.State] {
        return [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved]
    }
    
    /**
     Set string value of button's attributedTitle,
     keeping all attributes that was set before.
    
    - Parameter title: The new optional string value for attributedTitle.
    */
    func setAttributedTitleKeepingAttributes(to title: String?) {
        for state in UIButton.allControlStates {
            if let mutableAttributedTitle = attributedTitle(for: state)?.mutableCopy(),
                let mutableAttributedText = mutableAttributedTitle as? NSMutableAttributedString {
                let newTitle = title ?? ""
                mutableAttributedText.mutableString
                    .setString(newTitle.isEmpty ? LabelFactory.emptyText : newTitle)
                setAttributedTitle(mutableAttributedText, for: state)
            }
        }
    }
}
