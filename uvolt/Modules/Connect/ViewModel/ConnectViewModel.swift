//
//  ConnectViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import Foundation

class ConnectViewModel: ConnectViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: ConnectViewInput?
    var router: ConnectRouterInput?
    weak var moduleOutput: ConnectModuleOutput?
    // Список девайсов
    private var devices: [DeviceModel] = [] {
        didSet {
            view?.display(viewAdapter: .init(devices: devices))
        }
    }

    // ------------------------------
    // MARK: - ConnectViewOutput methods
    // ------------------------------

    func didLoad() {
        fetchDevices()
    }
    
    // 3.2. Метод перехода к экрану MainScreen
    func showMainPage() {
        router?.routeToMain()
    }
    
    // Метод нажатия на коннект либо на ячейку
    func didSelect(device: DeviceModel?) {
        guard let device = device else { return }
        print("Name: ", device.name)
        print("UUDID: ", device.uudid)
        showMainPage()
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func fetchDevices() {
        var devicesMock: [DeviceModel] = Array(repeating: .init(name: "BTName", uudid: "123e4567-e89b-12d3-a456-426655440000"), count: 4)
        modify(devices: &devicesMock)
        devices = devicesMock
    }
    
    // 3.1. Метод Добавление пункта списка (в метод мы передаем переменные name – string и UUID – string)
    private func addDevice(name: String, device: String) {
        devices.append(.init(name: name, uudid: device))
    }
    
    // 3.4. Метод очистки всего списка
    private func clearDevices() {
        devices = []
    }
    
    private func modify(devices: inout [DeviceModel]) {
        devices = devices.map({ (item) in
            return .init(name: item.name, uudid: item.uudid) { [weak self] in
                self?.didSelect(device: item)
            }
        })
    }
}

// ------------------------------
// MARK: - ConnectModuleInput methods
// ------------------------------

extension ConnectViewModel: ConnectModuleInput {
    func configure(data: ConnectConfigData) { }
}
