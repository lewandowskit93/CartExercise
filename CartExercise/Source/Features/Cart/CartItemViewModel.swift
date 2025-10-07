//
//  CartItemViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore

struct CartItemViewModel {
    let offer: Offer
    let name: String
    let price: String
    let quantityString: String
    let quantity: Double
    
    init(offer: Offer, name: String, price: String, quantityString: String, quantity: Double) {
        self.offer = offer
        self.name = name
        self.price = price
        self.quantityString = quantityString
        self.quantity = quantity
    }
}
