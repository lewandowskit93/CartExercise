//
//  CartModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import DependencyInjection

class CartModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    
    init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func build() -> UIViewController {
        let coordinator = CartCoordinator(diContainer: diContainer)
        let viewModel = CartViewModel(diContainer: diContainer, coordinator: coordinator)
        let controller = CartViewController(viewModel: viewModel)
        coordinator.setupController(controller: controller)
        controller.navigationItem.title = "Cart"
        controller.tabBarItem.title = "Cart"
        controller.tabBarItem.image = UIImage(systemName: "cart")?.withRenderingMode(.alwaysOriginal)
        let nav = NavigationModuleBuilder(diContainer: diContainer, contentBuilder: { _ in controller }).build()
        return nav
    }
}
