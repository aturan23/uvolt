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
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
}
