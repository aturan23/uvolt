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
        static let cardHeight: CGFloat = 112
    }
    var output: MainViewOutput?
    private var otherTypes: [InformationType] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

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
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(ParametersCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
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

    func display(viewAdapter: MainViewAdapter) {
        frameRoundedView.display(type: viewAdapter.frame)
        chargeRoundedView.display(type: viewAdapter.charge)
        otherTypes = viewAdapter.otherTypes
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func settingsDidTap() {
        output?.showSettingsPage()
    }
    
    @objc private func statisticsDidTap() {
        output?.showSpeedPage()
    }

    private func setupViews() {
        view.backgroundColor = .black
        segmentView.stateChanged = { (selected) in
            print(selected.rawValue)
        }
        statisticsButton.addTarget(self, action: #selector(statisticsDidTap), for: .touchUpInside)
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [navigationBar,
         frameRoundedView,
         chargeRoundedView,
         segmentView,
         collectionView,
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
            $0.height.equalTo(Constants.cardHeight)
            $0.width.equalToSuperview().multipliedBy(0.454)
        }
        chargeRoundedView.snp.makeConstraints {
            $0.top.equalTo(safeAreaTopInset)
            $0.right.equalTo(-16)
            $0.height.equalTo(Constants.cardHeight)
            $0.width.equalToSuperview().multipliedBy(0.454)
        }
        segmentView.snp.makeConstraints {
            $0.top.equalTo(frameRoundedView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(statisticsButton.snp.top).offset(-20)
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        otherTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ParametersCollectionViewCell = collectionView.dequeReusableCell(for: indexPath)
        let type = otherTypes[indexPath.row]
        cell.display(type: type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.2
        return CGSize(width: size, height: Constants.cardHeight)
    }
}
