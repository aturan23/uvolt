//
//  PreloadViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class PreloadViewController: BaseViewController, PreloadViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: PreloadViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
        view.backgroundColor = .green
    }

    // ------------------------------
    // MARK: - PreloadViewInput
    // ------------------------------

    func display(viewAdapter: PreloadViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() { }
    private func setupConstraints() { }
}
