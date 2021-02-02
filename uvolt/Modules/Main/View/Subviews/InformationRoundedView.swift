//
//  InformationRoundedView.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class InformationRoundedView: UIView {
    
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let radius: CGFloat = 14
    }
    private let labelFactory = LabelFactory()
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var titleLabel = labelFactory.make(
        withStyle: .paragraphBody,
        text: "dsfadfa",
        textColor: Color.textHighContrast,
        textAlignment: .center)

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
        layer.cornerRadius = Constants.radius
        backgroundColor = Color.grayBackground
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [titleLabel].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(16)
            $0.bottom.equalTo(-16)
        }
    }
}
