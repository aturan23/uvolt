//
//  ConnectViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class ConnectViewController: BaseViewController, ConnectViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: ConnectViewOutput?

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
        view.backgroundColor = .orange
    }

    // ------------------------------
    // MARK: - ConnectViewInput
    // ------------------------------

    func display(viewAdapter: ConnectViewAdapter) { }

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
