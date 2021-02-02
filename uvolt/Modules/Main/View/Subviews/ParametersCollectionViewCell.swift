//
//  ParametersCollectionViewCell.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class ParametersCollectionViewCell: UICollectionViewCell {
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let containerView = InformationRoundedView()
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = nil
//    }
    
    // ------------------------------
    // MARK: - Public methods
    // ------------------------------
    
    func display(type: InformationType) {
        containerView.display(type: type)
    }
    
    // ------------------------------
    // MARK: - Private
    // ------------------------------
    
    private func setupViews() {
        backgroundColor = .clear
        clipsToBounds = false
        
        setupViewsHierarchy()
        setupConstraints()
    }
    
    private func setupViewsHierarchy() {
        [containerView].forEach(contentView.addSubview(_:))
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
