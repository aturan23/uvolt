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
        static let buttonViewHeight: CGFloat = 28
    }
    private let labelFactory = LabelFactory()
    var didTap: (() -> ())?
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var titleLabel = labelFactory.make(withStyle: .headingH5, textColor: .white)
    private lazy var subtitleLabel = labelFactory.make(withStyle: .smallHelper, textColor: .white)
    private lazy var buttonLabel = labelFactory.make(
        withStyle: .headingH5,
        text: "CONNECT".localized().lowercased(),
        textColor: .white)
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.grayBackground
        view.layer.cornerRadius = Constants.buttonViewHeight / 2
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(continueDidTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRecognizer)
        return view
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
        didTap = device.continueDidTap
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func continueDidTap() {
        didTap?()
    }

    private func setupViews() {
        backgroundColor = .clear
        subtitleLabel.numberOfLines = 1
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [titleLabel,
         subtitleLabel,
         buttonView,
         buttonView].forEach(contentView.addSubview(_:))
        buttonView.addSubview(buttonLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(20)
            $0.right.equalTo(buttonView.snp.left).offset(-20)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.equalTo(16)
            $0.right.equalTo(buttonView.snp.left).offset(-20)
            $0.bottom.equalTo(-2)
        }
        buttonView.snp.makeConstraints {
            $0.right.equalTo(-16)
            $0.height.equalTo(Constants.buttonViewHeight)
            $0.width.equalTo(85)
            $0.centerY.equalToSuperview()
        }
        buttonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(8)
        }
    }
}
