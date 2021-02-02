//
//  SettingsViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, SettingsViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let resetButtonHeight = 60
    }
    var output: SettingsViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private let resetButton = Button(
        text: "RESET_ALL".localized(),
        textStyle: .headingH5,
        textColor: .white,
        backgroundColor: Color.grayBackground,
        cornerRadius: 14)
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - SettingsViewInput
    // ------------------------------

    func display(viewAdapter: SettingsViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func resetDidTap() {
        print("Reset")
    }

    private func setupViews() {
        view.backgroundColor = .black
        resetButton.addTarget(self, action: #selector(resetDidTap), for: .touchUpInside)

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [resetButton].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        resetButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(Constants.resetButtonHeight)
            $0.bottom.equalTo(-safeAreaBottomInset)
        }
    }
}
