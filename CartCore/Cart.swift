//
//  Cart.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

import Foundation

public struct Cart: Codable {
    public let cartId: UUID
    
    public init(cartId: UUID) {
        self.cartId = cartId
    }
}
