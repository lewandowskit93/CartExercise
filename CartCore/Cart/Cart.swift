//
//  Cart.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

import Foundation

public struct Cart: Codable {
    public let cartId: UUID
    public let cartItems: [CartItem]
    public let totalPrice: Price
    
    public init(cartId: UUID, cartItems: [CartItem], totalPrice: Price) {
        self.cartId = cartId
        self.cartItems = cartItems
        self.totalPrice = totalPrice
    }
}

public class CartHelper {
    public static func add(toCart cart: Cart, cartItem: CartItem, offerPrice: Price? = nil) -> Cart {
        if let item = cart.cartItems.first(where: { $0.offerId == cartItem.offerId }) {
            let modifiedItem = item.withQuantity(item.quantity + cartItem.quantity)
            var newItems = cart.cartItems.filter { $0.offerId != cartItem.offerId }
            newItems.append(modifiedItem)
            var newPrice = cart.totalPrice
            if let offerPrice = offerPrice {
                newPrice = Price(value: cart.totalPrice.value + Double(cartItem.quantity) * offerPrice.value, currency: cart.totalPrice.currency)
            }
            return Cart(cartId: cart.cartId, cartItems: newItems, totalPrice: newPrice)
        } else {
            var newItems = cart.cartItems
            newItems.append(cartItem)
            var newPrice = cart.totalPrice
            if let offerPrice = offerPrice {
                newPrice = Price(value: cart.totalPrice.value + Double(cartItem.quantity) * offerPrice.value, currency: cart.totalPrice.currency)
            }
            return Cart(cartId: cart.cartId, cartItems: newItems, totalPrice: newPrice)
        }
    }
    
    public static func remove(fromCart cart: Cart, cartItem: CartItem, offerPrice: Price? = nil) -> Cart {
        if let item = cart.cartItems.first(where: { $0.offerId == cartItem.offerId }) {
            var newQuantity = max(0, item.quantity - cartItem.quantity)
            var quantityDiff = item.quantity - newQuantity
            let modifiedItem = item.withQuantity(newQuantity)
            var newItems = cart.cartItems.filter { $0.offerId != cartItem.offerId }
            if(newQuantity > 0) {
                newItems.append(modifiedItem)
            }
            var newPrice = cart.totalPrice
            if let offerPrice = offerPrice {
                newPrice = Price(value: cart.totalPrice.value - Double(quantityDiff) * offerPrice.value, currency: cart.totalPrice.currency)
            }
            return Cart(cartId: cart.cartId, cartItems: newItems, totalPrice: newPrice)
        } else {
            return cart
        }
    }
}
