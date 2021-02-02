//
//  InformationType.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//


enum InformationType {
    
    case frame(num: String)
    case charge(num: Int)
    case avgSpeed(num: Float)
    case calories(num: Float)
    case distance(num: Float)
    case odo(num: Float)
    case avgPower(num: Float)
    case fuel(num: Float)
    
    var title: String {
        switch self {
        case .frame:
            return "FRAME".localized(up: true)
        case .charge:
            return "CHARGE_STATUS".localized(up: true)
        case .avgSpeed:
            return "AVG_SPEED".localized()
        case .calories:
            return "CALORIES".localized()
        case .distance:
            return "DISTANCE".localized()
        case .odo:
            return "ODO".localized()
        case .avgPower:
            return "AVG_POWER".localized()
        case .fuel:
            return "FUEL".localized()
        }
    }
    
    var imageName: String? {
        switch self {
        case .avgSpeed:
            return "speed"
        case .calories:
            return "heart"
        case .distance:
            return "marker"
        case .odo:
            return "distance"
        case .avgPower:
            return "fuel"
        case .fuel:
            return "fuel"
        default: return nil
        }
    }
}
