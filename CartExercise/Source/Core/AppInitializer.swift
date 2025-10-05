//
//  AppInitializer.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import BackendCore
import HttpClient
import DependencyInjection
import CartBackendMock
import CartSDK

class AppInitializer {
    func setupDependencies() throws {
        let container = DepsContainers.cartApp
        try container.registerLazySingleton(as: PBackendApp.self) { container in
            return try! createBackendMock()
        }
        try container.registerLazySingleton(as: PHttpRequester.self) { container in
            return BackendRequester(diContainer: container)
        }
        try container.registerLazySingleton(as: CartSdk.self) { container in
            return CartSdk(diContainer: container)
        }
        try container.registerSingleton(as: PAppStyle.self, item: DefaultAppStyle())
        try container.registerSingleton(as: PUIFactories.self, item: DefaultUIFactories())
        try container.resolve(CartSdk.self).setup()
    }
}
