//
//  ContainerExtension.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation
import Swinject

extension Container: ModuleInjecting {
    func inject<Dependency, Arg1, Arg2>(_ serviceType: Dependency.Type, argument: Arg1, argument1: Arg2) -> Dependency? {
        return resolve(serviceType, name: nil, arguments: argument, argument1)
    }
    
    func inject<Dependency, Arg1>(_ serviceType: Dependency.Type, argument: Arg1) -> Dependency? {
        return resolve(serviceType, name: nil, argument: argument)
    }
    
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency? {
        return self.resolve(serviceType)
    }
}
