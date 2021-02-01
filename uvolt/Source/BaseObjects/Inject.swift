//
//  Inject.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration

enum Inject {
    static var depContainer: Container = buildDefaultDepContainer()
    static func buildDefaultDepContainer() -> Container {
        let container = Container()
        return container
            .registerStorages()
            .registerLocalizer()
            .registerModules()
            .registerCoordinators()
    }
}

extension Container {
    
    func registerStorages() -> Self {
        register(FileManager.self) { _ in FileManager.default }
        return self
    }
    
    func registerLocalizer() -> Self {
        autoregister(LocalLocalizer.self,
                     initializer: LocalLocalizer.init(fileManager:))
            .inObjectScope(.container)
        return self
    }
    
    func registerModules() -> Self {
        self.register(PreloadModuleAssembly.self) { _ in
            PreloadModuleAssembly(injection: self)
        }
        self.register(ConnectModuleAssembly.self) { _ in
            ConnectModuleAssembly(injection: self)
        }
        return self
    }
    
    func registerCoordinators() -> Self {
        self.register(AppCoordinating.self) { (_: Resolver, window: UIWindow) in
            AppCoordinator(window: window, injection: self)
        }
        return self
    }
}
