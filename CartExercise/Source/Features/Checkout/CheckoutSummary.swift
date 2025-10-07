//
//  CheckoutSummary.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import Foundation

struct CheckoutSummaryItem {
    let offerId: UUID
    let name: String
    let price: Price
    let unit: CartCore.Unit
    let quantity: Int
    
    init(offerId: UUID, name: String, price: Price, unit: CartCore.Unit, quantity: Int) {
        self.offerId = offerId
        self.name = name
        self.price = price
        self.unit = unit
        self.quantity = quantity
    }
}

struct CheckoutSummary {
    let checkoutSummaryItems: [CheckoutSummaryItem]
    let totalPrice: Price
    
    init(checkoutSummaryItems: [CheckoutSummaryItem], totalPrice: Price) {
        self.checkoutSummaryItems = checkoutSummaryItems
        self.totalPrice = totalPrice
    }
}
