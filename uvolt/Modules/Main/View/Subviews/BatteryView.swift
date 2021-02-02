//
//  BatteryView.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class BatteryView: UIView {
   
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let mainBorderSize: CGSize = .init(width: 76, height: 40)
        static let smallBorderSize: CGSize = .init(width: 9, height: 25)
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let borderView = UIView()
    private let smallBorderView = UIView()
    private let levelView = UIView()

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
        
        levelView.backgroundColor = .red
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [borderView, smallBorderView].forEach(addSubview(_:))
        [levelView].forEach(borderView.addSubview(_:))
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
            $0.right.equalToSuperview().multipliedBy(0.5)
        }
    }
}
