//
//  HomeCoordinator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection
import UIKit

protocol PHomeCoordinator {
    func openCart()
}

class HomeCoordinator: PHomeCoordinator {
    let diContainer: PDIContainer
    private weak var controller: HomeViewController!

    required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func setupController(controller: HomeViewController) {
        self.controller = controller
    }
    
    func openCart() {
        let home = CartModuleBuilder(diContainer: diContainer)
        let cartController = home.build()
        controller.addChild(cartController)
        controller.view.addSubview(cartController.view)
        cartController.view.pinToParent()
    }
}
