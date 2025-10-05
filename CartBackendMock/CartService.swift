//
//  CartService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

import CartCore
import Foundation
import DependencyInjection

public class CartService: PCartService, PInitiableWithDIContainer, PHasDIContainer {
    public let diContainer: PDIContainer

    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    
    public func getCart() async -> Cart {
        return Cart(cartId: UUID.init())
    }
}
