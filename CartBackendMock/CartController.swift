//
//  CartController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import CartCore
import DependencyInjection
import BackendCore
internal import NetworkingCore

public class CartController: PController, PHasDIContainer {
    public let diContainer: PDIContainer

    @Inject(.enclosingInstance)
    private var cartService: PCartService
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getCart() async throws -> Cart {
        let cart = try await cartService.getCart()
        return cart
    }
    
    public func registerRoutes(router: PRouteRegistrar) throws {
        try router.registerRoute(
            path: "/cart",
            method: .get,
            allowsEmptyRequestContent: true,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: getCart
        )
    }
}
