//
//  ShopItemViewStyle.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

enum ShopItemViewStyle {
    case light
    case dark
    
    var isLight: Bool {
        switch(self) {
            case .light: return true
            default: return false
        }
    }
}
