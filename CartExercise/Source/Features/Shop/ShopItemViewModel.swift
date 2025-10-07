//
//  ShopItemViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import UIKit

struct ShopItemViewModel {
    let offer: Offer
    let name: String
    let price: String
    let stock: String
    let addToCartButtonVisible: Bool
    let addToCartButtonTitle: String
    let addToCartButtonIcon: UIImage?
    
    init(offer: Offer, name: String, price: String, stock: String, addToCartButtonVisible: Bool, addToCartButtonTitle: String, addToCartButtonIcon: UIImage?) {
        self.offer = offer
        self.name = name
        self.price = price
        self.stock = stock
        self.addToCartButtonVisible = addToCartButtonVisible
        self.addToCartButtonTitle = addToCartButtonTitle
        self.addToCartButtonIcon = addToCartButtonIcon
    }
}
