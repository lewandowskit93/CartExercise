//
//  CartRepository.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import DependencyInjection
import Foundation

public protocol PCartRepository {
    func getCart() async throws -> Cart
    func saveCart(cart: Cart) async throws
}

public class CartRepository: PCartRepository, PInitiable {
    private var cart: Cart
    
    public required init() {
        cart = Cart(cartId: UUID(), cartItems: [], totalPrice: .init(value: 0, currency: .USD))
    }
    
    public func getCart() async throws -> CartCore.Cart {
        return cart
    }
    
    public func saveCart(cart: CartCore.Cart) async throws {
        self.cart = cart
    }
}
