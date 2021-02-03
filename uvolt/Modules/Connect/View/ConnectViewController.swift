//
//  ConnectViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class ConnectViewController: BaseViewController, ConnectViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    private enum Constants {
        static let tableViewEstimatedRowHeight: CGFloat = 60
    }
    var output: ConnectViewOutput?
    private var devices: [DeviceModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .white
        tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
        let emptyView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView = emptyView
        tableView.tableFooterView = emptyView
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(ConnectTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - ConnectViewInput
    // ------------------------------

    func display(viewAdapter: ConnectViewAdapter) {
        devices = viewAdapter.devices
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        view.backgroundColor = .black
        title = "CONNECT".localized()
        navigationItem.setHidesBackButton(true, animated: true)
        
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [tableView].forEach(view.addSubview(_:))
    }
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.bottom.equalToSuperview()
        }
    }
}

// ------------------------------
// MARK: - UITableViewDelegate & UITableViewDataSource methods
// ------------------------------

extension ConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ConnectTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let device = devices[indexPath.row]
        cell.display(device: device)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Метод реагирует так же как и на нажатий на connect кнопку. При желаний можно включить
//        output?.didSelect(device: devices[indexPath.row])
    }
}
