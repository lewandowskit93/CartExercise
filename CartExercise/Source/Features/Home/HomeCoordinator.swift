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
    
    func openShop() {
        controller.selectedIndex = 0
    }
    
    func openCart() {
        controller.selectedIndex = 1
    }
}
