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
        static let percentColor = #colorLiteral(red: 0.4823529412, green: 0.5803921569, blue: 0.9450980392, alpha: 1)
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
                withStyle: .headingH4,
                text: num,
                textColor: .white,
                textAlignment: .center)
            addSubview(frameLabel)
            frameLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        case .charge(let num):
            let batteryView = BatteryView()
            batteryView.level = num
            addSubview(batteryView)
            batteryView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .avgSpeed(let num):
            let view = buildImagedLabelView(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .calories(let num):
            let view = buildImagedLabelView(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .distance(let num):
            let view = buildImagedLabelView(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .odo(let num):
            let view = buildImagedLabelView(image: type.imageName, value: num)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case let .avgPower(power, wat):
            let view = buildPowerView(image: type.imageName, power: power, wat: wat)
            addSubview(view)
            view.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
            }
        case .fuel(let num):
            let view = buildImagedLabelView(image: type.imageName, value: num)
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
    
    private func buildImagedLabelView(image: String?, value: Float) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        let imageView = UIImageView(image: UIImage(named: image ?? ""))
        imageView.frame = Constants.imageFrame
        
        let label = labelFactory.make(
            withStyle: .headingH4,
            text: "\(value)",
            textColor: .white)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
    private func buildPowerView(image: String?, power: Float, wat: Float) -> UIView {
        let sum = power + wat
        let powerPercent = ( power * 100 ) / sum
        let watPercent = ( wat * 100 ) / sum
        
        let powerLabel = labelFactory.make(
            withStyle: .paragraphBody,
            text: "\(power)",
            textColor: .white,
            textAlignment: .right)
        let powerPercentLabel = labelFactory.make(
            withStyle: .paragraphBody,
            text: "\( Int(round(powerPercent)) )%",
            textColor: Constants.percentColor,
            textAlignment: .right)
        
        let watLabel = labelFactory.make(
            withStyle: .paragraphBody,
            text: "\(wat)",
            textColor: .white)
        let watPercentLabel = labelFactory.make(
            withStyle: .paragraphBody,
            text: "\( Int(round(watPercent)) )%",
            textColor: Constants.percentColor)
        
        let imageView = UIImageView(image: UIImage(named: image ?? ""))
        imageView.frame = Constants.imageFrame
        
        let containerView = UIView()
        [powerLabel, powerPercentLabel, imageView, watLabel, watPercentLabel].forEach(containerView.addSubview(_:))
        
        powerLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
        powerPercentLabel.snp.makeConstraints {
            $0.right.equalTo(powerLabel)
            $0.bottom.equalTo(imageView)
        }
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(powerLabel.snp.right).offset(4)
        }
        watLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(4)
        }
        watPercentLabel.snp.makeConstraints {
            $0.left.equalTo(watLabel)
            $0.bottom.equalTo(imageView)
        }
        
        return containerView
    }
}
