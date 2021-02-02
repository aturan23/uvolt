//
//  BatteryView.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit
import SnapKit

class BatteryView: UIView {
   
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let mainBorderSize: CGSize = .init(width: 76, height: 40)
        static let smallBorderSize: CGSize = .init(width: 9, height: 25)
    }
    var level: Int = 0 {
        didSet {
            layoutLevel()
        }
    }
    private var levelWidthConstraint: Constraint?
    private lazy var levelWidth: CGFloat = CGFloat(level)
    private var fillColor: UIColor = .red
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let borderView = UIView()
    private let smallBorderView = UIView()
    private let levelView = UIView()
    private var energyImageView = UIImageView(frame: .init(x: 0, y: 0, width: 8, height: 16))
    private var statusView = UIView()
    private let levelLabel = LabelFactory().make(withStyle: .headingH4,
                                             text: "0",
                                             textColor: .white)

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        smallBorderView.roundCorners(corners: [.topRight, .bottomRight], radius: 7)
        borderView.layer.cornerRadius = 7
        
        var pathWidth = 15
        if (86...100).contains(level) {
            pathWidth = 0
        }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: levelWidth, y: 0))
        path.addLine(to: CGPoint(x: levelWidth + CGFloat(pathWidth), y: 0))
        path.addLine(to: CGPoint(x: levelWidth + 0, y: Constants.mainBorderSize.height))
        path.addLine(to: CGPoint(x: levelWidth + 0, y: 0))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = 3
        levelView.layer.addSublayer(shapeLayer)
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        backgroundColor = .clear
        
        [borderView, smallBorderView].forEach {
            $0.layer.borderWidth = 2
            $0.layer.borderColor = Color.mainWhite.cgColor
        }
        
        levelView.backgroundColor = fillColor
        energyImageView.image = UIImage(named: "energy")
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [borderView, smallBorderView].forEach(addSubview(_:))
        [levelView, statusView].forEach(borderView.addSubview(_:))
        statusView.addSubview(levelLabel)
        [energyImageView, levelLabel].forEach(statusView.addSubview(_:))
    }
    
    private func setupConstraints() {
        borderView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.size.equalTo(Constants.mainBorderSize)
        }
        smallBorderView.snp.makeConstraints {
            $0.centerY.equalTo(borderView.snp.centerY)
            $0.left.equalTo(borderView.snp.right).offset(-2)
            $0.size.equalTo(Constants.smallBorderSize)
            $0.right.equalToSuperview()
        }
        levelView.snp.makeConstraints {
            $0.left.height.equalToSuperview()
            levelWidthConstraint = $0.width.equalTo(0).constraint
        }
        statusView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        energyImageView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        levelLabel.snp.makeConstraints {
            $0.left.equalTo(energyImageView.snp.right).offset(4)
            $0.centerY.equalTo(energyImageView)
            $0.right.equalToSuperview()
        }
    }
    
    private func layoutLevel() {
        if level >= 0 && level <= 100 {
            levelLabel.text = "\(level)"
            levelWidth = ( CGFloat(level) * Constants.mainBorderSize.width ) / 100
            levelWidthConstraint?.update(offset: levelWidth)
        }
        layoutFillColor()
    }
    
    private func layoutFillColor() {
        switch level {
        case 0...10:
            fillColor = .red
        case 11...20:
            fillColor = .yellow
        case 21...100:
            fillColor = .green
        default:
            fillColor = .red
        }
        levelView.backgroundColor = fillColor
    }
}
