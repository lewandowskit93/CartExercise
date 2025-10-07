//
//  CheckoutItemViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import Foundation

struct CheckoutItemViewModel {
    let offerId: UUID
    let name: String
    let price: String
    let quantityString: String
    
    init(offerId: UUID, name: String, price: String, quantityString: String) {
        self.offerId = offerId
        self.name = name
        self.price = price
        self.quantityString = quantityString
    }
}
