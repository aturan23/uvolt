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
        static let imageFrame: CGRect = .init(x: 0, y: 0, width: 44, height: 44)
    }
    private let labelFactory = LabelFactory()
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var titleLabel = labelFactory.make(
        withStyle: .paragraphBody,
        textColor: Color.textHighContrast,
        textAlignment: .center)

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    func display(type: InformationType) {
        titleLabel.text = type.title
        switch type {
        case .frame(let num):
            let frameLabel = labelFactory.make(
                withStyle: .headingH5,
                text: num,
                textColor: .white,
                textAlignment: .center)
            addSubview(frameLabel)
            frameLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        case .charge(let num):
            let frameLabel = labelFactory.make(
                withStyle: .headingH5,
                text: "\(num)",
                textColor: .white,
                textAlignment: .center)
            addSubview(frameLabel)
            frameLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        case .avgSpeed(let num):
            let view = buildImagedLabel(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .calories(let num):
            let view = buildImagedLabel(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .distance(let num):
            let view = buildImagedLabel(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .odo(let num):
            let view = buildImagedLabel(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .avgPower(let num):
            let view = buildImagedLabel(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .fuel(let num):
            let view = buildImagedLabel(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        }
    }
    
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
        }
    }
    
    private func buildImagedLabel(image: String?, value: Float) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        let imageView = UIImageView(image: UIImage(named: image ?? ""))
        imageView.frame = Constants.imageFrame
        
        let label = labelFactory.make(
            withStyle: .headingH5,
            text: "\(value)",
            textColor: .white)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
}
