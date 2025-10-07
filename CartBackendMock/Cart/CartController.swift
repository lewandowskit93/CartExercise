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
    
    public func addToCart(cartItem: CartItem, requestContext: RequestContext) async throws -> Bool {
        let success = try await cartService.addToCart(cartItem: cartItem)
        return success
    }
    
    public func removeFromCart(cartItem: CartItem, requestContext: RequestContext) async throws {
        try await cartService.removeFromCart(cartItem: cartItem)
    }
    
    public func clearCart() async throws {
        try await cartService.clearCart()
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
        try router.registerRoute(
            path: "/cart",
            method: .delete,
            allowsEmptyRequestContent: true,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: clearCart
        )
        try router.registerRoute(
            path: "/cart/item",
            method: .post,
            allowsEmptyRequestContent: false,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: addToCart
        )
        try router.registerRoute(
            path: "/cart/item",
            method: .delete,
            allowsEmptyRequestContent: false,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: removeFromCart
        )
    }
}
