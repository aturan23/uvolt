//
//  SettingsViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, SettingsViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let resetButtonHeight = 60
        static let cellIdentifier = "cellIdentifier"
        static let headerIdentifier = "headerIdentifier"
        static let frameList: [SettingFrameType] = [.name,
                                                    .measurment,
                                                    .distance,
                                                    .odometer,
                                                    .calory,
                                                    .cost,
                                                    .log,
                                                    .firmware,
                                                    .language]
    }
    var output: SettingsViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .black
        view.register(SettingsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        view.register(SettingTableHeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier)
        
        return view
    }()

    private let resetButton = Button(
        text: "RESET_ALL".localized(),
        textStyle: .headingH5,
        textColor: .white,
        backgroundColor: Color.grayBackground,
        cornerRadius: 14)
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Settings"
    }

    // ------------------------------
    // MARK: - SettingsViewInput
    // ------------------------------

    func display(viewAdapter: SettingsViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func resetDidTap() {
        print("Reset")
    }

    private func setupViews() {
        view.backgroundColor = .black
        resetButton.addTarget(self, action: #selector(resetDidTap), for: .touchUpInside)

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [resetButton, tableView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        resetButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(Constants.resetButtonHeight)
            $0.bottom.equalTo(-safeAreaBottomInset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(resetButton.snp.top).offset(-12)
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.frameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! SettingsTableViewCell
        cell.display(by: Constants.frameList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: SettingTableHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerIdentifier) as! SettingTableHeaderView
        
        return view
    }
}
