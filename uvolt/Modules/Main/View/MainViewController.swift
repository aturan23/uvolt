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

    private enum Constants {
        static let statisticsImageName = "statistics"
        static let selectModeImageName = "select_mode"
    }
    var output: MainViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private let frameRoundedView = InformationRoundedView()
    private let chargeRoundedView = InformationRoundedView()
    private let segmentView = PeriodSegmentControlView()
    private let statisticsButton = Button(
        icon: UIImage(named: Constants.statisticsImageName),
        text: "MORE_STATS".localized(),
        textStyle: .headingH5,
        textColor: .white,
        backgroundColor: Color.grayBackground,
        cornerRadius: 9)
    private let selectModeButton = Button(
        icon: UIImage(named: Constants.selectModeImageName),
        text: "SELECT_MODE".localized(),
        textStyle: .headingH5,
        textColor: .white,
        backgroundColor: Color.grayBackground,
        cornerRadius: 9)
    
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
        [frameRoundedView,
         chargeRoundedView,
         segmentView,
         statisticsButton,
         selectModeButton].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        frameRoundedView.snp.makeConstraints {
            $0.top.equalTo(safeAreaTopInset)
            $0.left.equalTo(16)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
        chargeRoundedView.snp.makeConstraints {
            $0.top.equalTo(safeAreaTopInset)
            $0.right.equalTo(-16)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
        segmentView.snp.makeConstraints {
            $0.top.equalTo(frameRoundedView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        statisticsButton.snp.makeConstraints {
            $0.left.equalTo(14)
            $0.height.equalTo(60)
            $0.bottom.equalTo(-safeAreaBottomInset)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
        selectModeButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.equalTo(-safeAreaBottomInset)
            $0.right.equalTo(-14)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
    }
}
