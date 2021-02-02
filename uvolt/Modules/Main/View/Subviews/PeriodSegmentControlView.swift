//
//  PeriodSegmentControlView.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class PeriodSegmentControlView: UIView {
    
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let buttonViewHeight: CGFloat = 33
    }
    var selected: SegmentPeriod = .today {
        didSet {
            switch selected {
            case .today:
                todayButton.isPressed = true
                weekButton.isPressed = false
                allTimeButton.isPressed = false
            case .week:
                todayButton.isPressed = false
                weekButton.isPressed = true
                allTimeButton.isPressed = false
            case .allTime:
                todayButton.isPressed = false
                weekButton.isPressed = false
                allTimeButton.isPressed = true
            }
        }
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let todayButton = Button(
        text: "TODAY".localized(up: true),
        textStyle: .paragraphBody,
        textColor: .white,
        backgroundColor: Color.darkSegmentBackground,
        pressedColor: Color.grayBackground,
        cornerRadius: 4)
    private let weekButton = Button(
        text: "WEEK".localized(up: true),
        textStyle: .paragraphBody,
        textColor: .white,
        backgroundColor: Color.darkSegmentBackground,
        pressedColor: Color.grayBackground,
        cornerRadius: 4)
    private let allTimeButton = Button(
        text: "ALL_TIME".localized(up: true),
        textStyle: .paragraphBody,
        textColor: .white,
        backgroundColor: Color.darkSegmentBackground,
        pressedColor: Color.grayBackground,
        cornerRadius: 4)

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func todayDidTap() { selected = .today }
    @objc private func weekDidTap() { selected = .week }
    @objc private func allTimeDidTap() { selected = .allTime }

    private func setupViews() {
        backgroundColor = .clear
        todayButton.isPressed = true
        
        todayButton.addTarget(self, action: #selector(todayDidTap), for: .touchUpInside)
        weekButton.addTarget(self, action: #selector(weekDidTap), for: .touchUpInside)
        allTimeButton.addTarget(self, action: #selector(allTimeDidTap), for: .touchUpInside)
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [todayButton, weekButton, allTimeButton].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        todayButton.snp.makeConstraints {
            $0.left.bottom.top.equalToSuperview()
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.33)
        }
        weekButton.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.33)
        }
        allTimeButton.snp.makeConstraints {
            $0.right.top.equalToSuperview()
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.33)
        }
    }
}
