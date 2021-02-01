//
//  ConnectTableViewCell.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class ConnectTableViewCell: UITableViewCell {
    
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let buttonHeight: CGFloat = 28
    }
    private let labelFactory = LabelFactory()
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var titleLabel = labelFactory.make(withStyle: .headingH5, textColor: .white)
    private lazy var subtitleLabel = labelFactory.make(withStyle: .smallHelper, textColor: .white)
    private let connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("CONNECT".localized().lowercased(), for: .normal)
        return button
    }()

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(device: DeviceModel) {
        titleLabel.text = device.name
        subtitleLabel.text = device.uudid
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        backgroundColor = .clear
        connectButton.backgroundColor = Color.grayBackground
        connectButton.layer.cornerRadius = Constants.buttonHeight / 2
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [titleLabel, subtitleLabel, connectButton].forEach(contentView.addSubview(_:))
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(20)
            $0.right.equalTo(connectButton.snp.left).offset(-20)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.equalTo(16)
            $0.right.equalTo(connectButton.snp.left).offset(-20)
            $0.bottom.equalTo(-2)
        }
        connectButton.snp.makeConstraints {
            $0.right.equalTo(-16)
            $0.height.equalTo(Constants.buttonHeight)
            $0.centerY.equalToSuperview()
        }
    }
}
