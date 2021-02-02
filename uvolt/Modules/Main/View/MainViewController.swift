//
//  MainViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    private enum Constants {
        static let statisticsImageName = "statistics"
        static let selectModeImageName = "select_mode"
    }
    var output: MainViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------

    private lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        let navigationItem = UINavigationItem()
        navigationItem.title = "INFORMATION_CENTRE".localized().capitalized
        
        let gearItem = UIBarButtonItem(
            image: UIImage(named: "gear"),
            style: .plain,
            target: self,
            action: #selector(settingsDidTap))
        navigationItem.rightBarButtonItem = gearItem
        bar.setItems([navigationItem], animated: false)
        bar.tintColor = .blue
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        return bar
    }()
    private let frameRoundedView = InformationRoundedView()
    private let chargeRoundedView = InformationRoundedView()
    private let segmentView = PeriodSegmentControlView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize = CGSize(width: Constants.carouselItemSize,
//                                          height: Constants.carouselItemSize)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(ParametersCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        return collectionView
    }()
    private let statisticsButton = Button(
        icon: UIImage(named: Constants.statisticsImageName),
        text: "MORE_STATS".localized(),
        textStyle: .headingH5,
        textColor: .white,
        backgroundColor: Color.grayBackground,
        cornerRadius: 9)
    private let selectModeButton = Button(
        icon: UIImage(named: Constants.selectModeImageName),
        text: "SELECT_MODE".localized(),
        textStyle: .headingH5,
        textColor: .white,
        backgroundColor: Color.grayBackground,
        cornerRadius: 9)
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // ------------------------------
    // MARK: - MainViewInput
    // ------------------------------

    func display(viewAdapter: MainViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func settingsDidTap() {
        output?.showSettingsPage()
    }

    private func setupViews() {
        view.backgroundColor = .black

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [navigationBar,
         frameRoundedView,
         chargeRoundedView,
         segmentView,
         statisticsButton,
         selectModeButton].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        frameRoundedView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.equalTo(16)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
        chargeRoundedView.snp.makeConstraints {
            $0.top.equalTo(safeAreaTopInset)
            $0.right.equalTo(-16)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
        segmentView.snp.makeConstraints {
            $0.top.equalTo(frameRoundedView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        statisticsButton.snp.makeConstraints {
            $0.left.equalTo(14)
            $0.height.equalTo(60)
            $0.bottom.equalTo(-safeAreaBottomInset)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
        selectModeButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.equalTo(-safeAreaBottomInset)
            $0.right.equalTo(-14)
            $0.width.equalToSuperview().multipliedBy(0.455)
        }
    }
}

// ------------------------------
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource methods
// ------------------------------

extension MainViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ParametersCollectionViewCell = collectionView.dequeReusableCell(for: indexPath)
        return cell
    }
}
