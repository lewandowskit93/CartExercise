//
//  PCartService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

import Foundation

public protocol PCartService {
    func getCart() async throws -> Cart
    func addToCart(cartItem: CartItem) async throws -> Bool
    func removeFromCart(cartItem: CartItem) async throws
    func clearCart() async throws
}
