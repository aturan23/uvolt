//
//  SettingTableHeaderView.swift
//  uvolt
//
//  Created by Eldor Makkambayev on 03.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class SettingTableHeaderView: UITableViewHeaderFooterView {

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .white
        label.text = "FRAME №"

        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .white
        label.text = "1 000 000"
        label.textAlignment = .right

        return label
    }()

    
    // ------------------------------
    // MARK: - Initializate
    // ------------------------------

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ------------------------------
    // MARK: - Setups
    // ------------------------------

    private func setupViews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        tintColor = .black
        [titleLabel, valueLabel].forEach(contentView.addSubview(_:))
                
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(24)
            $0.bottom.equalTo(-24)
            $0.left.equalTo(16)
        })
        
        valueLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-16)
        })
    }
}

