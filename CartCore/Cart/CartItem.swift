//
//  CartItem.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import Foundation

public struct CartItem: Codable {
    public let offerId: UUID
    public let quantity: Int
    
    public init(offerId: UUID, quantity: Int) {
        self.offerId = offerId
        self.quantity = quantity
    }
}

public extension CartItem {
    func withQuantity(_ quantity: Int) -> CartItem {
        return CartItem(offerId: offerId, quantity: quantity)
    }
}
