//
//  CartViewState.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore

enum CartViewState {
    case empty(caption: String)
    case loading
    case loadingOffers(Cart)
    case content(Cart, [CartSectionItem])
    
    var isCheckoutButtonVisible: Bool {
        switch(self) {
            case .content(_, let models) where !models.isEmpty: return true
            default: return false
        }
    }
    
    var sectionItems: [CartSectionItem] {
        switch(self) {
            case .content(_, let models):
                return models
            default:
            return []
        }
    }
}

