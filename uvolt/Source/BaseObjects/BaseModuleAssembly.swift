//
//  BaseModuleAssembly.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation
import Swinject

class BaseModuleAssembly {
    var injection: ModuleInjecting
    required init(injection: ModuleInjecting) {
        self.injection = injection
    }
}

/// Buffer protocol from Swinject to Feature Module Assemblies to provide dependencies
/// It provides an abstraction, allowing for assemblies to not be aware of 3rd-party lib existence
protocol ModuleInjecting {
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency?
    func inject<Dependency, Arg1>(_ serviceType: Dependency.Type, argument: Arg1) -> Dependency?
    func inject<Dependency, Arg1, Arg2>(_ serviceType: Dependency.Type, argument: Arg1, argument1: Arg2) -> Dependency?
}
