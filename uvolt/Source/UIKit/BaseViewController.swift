//
//  BaseViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    var safeAreaTopInset: CGFloat {
        return UIApplication.shared.statusBarFrame.height
            + UINavigationController().navigationBar.bounds.height
    }
    
    var safeAreaBottomInset: CGFloat {
        let inset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return inset == 0 ? 8 : inset
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
}
