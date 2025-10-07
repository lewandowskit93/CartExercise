//
//  ShopCoordinator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import CartCore
import DependencyInjection
import UIKit

protocol PShopCoordinator {
    func goToOffer(offer: Offer)
}

class ShopCoordinator: PShopCoordinator {
    let diContainer: PDIContainer
    private weak var controller: ShopViewController!

    required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func setupController(controller: ShopViewController) {
        self.controller = controller
    }
    
    func goToOffer(offer: Offer) {
        let checkoutBuilder = OfferDetailsModuleBuilder(diContainer: diContainer, offer: offer)
        let checkoutVC = checkoutBuilder.build()
        controller.navigationController!.pushViewController(
            checkoutVC,
            animated: true
        )
    }
}
