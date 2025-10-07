//
//  ShopModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import DependencyInjection

class ShopModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    
    init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func build() -> UIViewController {
        let viewModel = ShopViewModel(diContainer: diContainer)
        let coordinator = ShopCoordinator(diContainer: diContainer)
        let controller = ShopViewController(viewModel: viewModel, coordinator: coordinator)
        coordinator.setupController(controller: controller)
        controller.navigationItem.title = "Shop"
        controller.tabBarItem.title = "Shop"
        controller.tabBarItem.image = UIImage(systemName: "bag")?.withRenderingMode(.alwaysOriginal)
        let nav = NavigationModuleBuilder(diContainer: diContainer, contentBuilder: { _ in controller }).build()
        return nav
    }
}
