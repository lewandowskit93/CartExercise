//
//  CheckoutSummaryViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

struct CheckoutSummaryViewModel {
    let uniqueItemsInCartTitle: String
    let uniqueItemsInCartValue: String
    let totalPriceTitle: String
    let totalPriceValue: String
    
    init(uniqueItemsInCartTitle: String, uniqueItemsInCartValue: String, totalPriceTitle: String, totalPriceValue: String) {
        self.uniqueItemsInCartTitle = uniqueItemsInCartTitle
        self.uniqueItemsInCartValue = uniqueItemsInCartValue
        self.totalPriceTitle = totalPriceTitle
        self.totalPriceValue = totalPriceValue
    }
}
