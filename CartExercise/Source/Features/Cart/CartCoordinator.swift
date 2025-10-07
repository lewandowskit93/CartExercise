//
//  CartCoordinator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import UIKit

protocol PCartCoordinator {
    func goToCheckout(summary: CheckoutSummary)
}

class CartCoordinator: PCartCoordinator {
    let diContainer: PDIContainer
    private weak var controller: CartViewController!

    required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func setupController(controller: CartViewController) {
        self.controller = controller
        
    }
    
    func goToCheckout(summary: CheckoutSummary) {
        let checkoutBuilder = CheckoutModuleBuilder(diContainer: diContainer, summary: summary)
        let checkoutVC = checkoutBuilder.build()
        controller.navigationController!.pushViewController(
            checkoutVC,
            animated: true
        )
    }
}
