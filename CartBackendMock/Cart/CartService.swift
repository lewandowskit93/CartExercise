//
//  CartService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

import CartCore
import Foundation
import DependencyInjection

public class CartService: PCartService, PInitiableWithDIContainer, PHasDIContainer {
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var repository: PCartRepository
    @Inject(.enclosingInstance)
    private var offersService: POffersService

    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getCart() async throws -> Cart {
        return try await repository.getCart()
    }
    
    public func addToCart(cartItem: CartCore.CartItem) async throws -> Bool {
        let offer = try await offersService.getOfferDetails(offerId: cartItem.offerId)
        guard offer.availableUnits >= cartItem.quantity else { return false }
        let cart = try await repository.getCart()
        let modifiedCart = CartHelper.add(toCart: cart, cartItem: cartItem, offerPrice: offer.price)
        try await repository.saveCart(cart: modifiedCart)
        return true
    }
    
    public func removeFromCart(cartItem: CartCore.CartItem) async throws {
        let offer = try await offersService.getOfferDetails(offerId: cartItem.offerId)
        let cart = try await repository.getCart()
        let modifiedCart = CartHelper.remove(fromCart: cart, cartItem: cartItem, offerPrice: offer.price)
        try await repository.saveCart(cart: modifiedCart)
    }
    
    public func clearCart() async throws {
        let newCart = Cart(cartId: UUID(), cartItems: [], totalPrice: .init(value: 0.0, currency: .USD))
        try await repository.saveCart(cart: newCart)
    }
}
