//
//  SpeedViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class SpeedViewController: BaseViewController, SpeedViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: SpeedViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
      AppDelegate.AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
    }
        
    override func viewWillDisappear(_ animated : Bool) {
      super.viewWillDisappear(animated)
      AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - SpeedViewInput
    // ------------------------------

    func display(viewAdapter: SpeedViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        title = "Speed"
        view.backgroundColor = .black

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {

    }

    private func setupConstraints() {
        
    }
}
