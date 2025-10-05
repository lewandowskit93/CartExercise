//
//  CartSDK.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection
import HttpClient

public class CartSdk: PInitiableWithDIContainer, PHasDIContainer {
    public let diContainer: any DependencyInjection.PDIContainer

    public required init(diContainer: any DependencyInjection.PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func setup() throws {
        try diContainer.registerLazySingleton(as: PAuthorizedCartClient.self) { deps in
            return AuthorizedCartClient(requester: try deps.resolve(PHttpRequester.self))
        }
        try diContainer.registerLazySingleton(as: PUnauthorizedCartClient.self) { deps in
            return UnauthorizedCartClient(requester: try deps.resolve(PHttpRequester.self))
        }
        try diContainer.registerLazySingleton(as: PCartService.self) { deps in
            return CartService(diContainer: deps)
        }
    }
}
