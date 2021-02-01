//
//  DeviceModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//


struct DeviceModel {
    let name: String
    let uudid: String
    var continueDidTap: (() -> ())? = nil
}
