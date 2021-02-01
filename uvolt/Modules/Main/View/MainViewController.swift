//
//  MainViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: MainViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private let segmentView = PeriodSegmentControlView()
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - MainViewInput
    // ------------------------------

    func display(viewAdapter: MainViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        view.backgroundColor = .black

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [segmentView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        segmentView.snp.makeConstraints {
            $0.top.equalTo(safeAreaTopInset)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
}
