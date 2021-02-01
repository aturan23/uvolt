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
                todayView.selected = true
                weekView.selected = false
                allTimeView.selected = false
            case .week:
                todayView.selected = false
                weekView.selected = true
                allTimeView.selected = false
            case .allTime:
                todayView.selected = false
                weekView.selected = false
                allTimeView.selected = true
            }
        }
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let todayView = ButtonView(text: "TODAY".localized())
    private let weekView = ButtonView(text: "WEEK".localized())
    private let allTimeView = ButtonView(text: "ALL_TIME".localized())

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

    private func setupViews() {
        backgroundColor = .clear
        todayView.selected = true
        
        todayView.didTap = { [weak self] in self?.selected = .today }
        weekView.didTap = { [weak self] in self?.selected = .week }
        allTimeView.didTap = { [weak self] in self?.selected = .allTime }
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [todayView, weekView, allTimeView].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        todayView.snp.makeConstraints {
            $0.left.bottom.top.equalToSuperview()
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.33)
        }
        weekView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.33)
        }
        allTimeView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.33)
        }
    }
}

private class ButtonView: UIView {
    
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private let labelFactory = LabelFactory()
    var didTap: (() -> ())?
    var selected: Bool = false {
        didSet {
            backgroundColor = Color.grayBackground
        }
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var titleLabel = labelFactory.make(
        withStyle: .paragraphBody,
        textColor: .white,
        textAlignment: .center)
    
    init(text: String) {
        super.init(frame: .zero)
        setupViews()
        titleLabel.text = text.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func viewDidTap() {
        guard !selected else { return }
        didTap?()
    }
    
    private func setupViews() {
        isUserInteractionEnabled = true
        let recognizer = UIGestureRecognizer(target: self, action: #selector(viewDidTap))
        addGestureRecognizer(recognizer)
        
        layer.cornerRadius = 4
        backgroundColor = Color.darkSegmentBackground
        titleLabel.textColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
