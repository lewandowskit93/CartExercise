//
//  HomeModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import DependencyInjection

class HomeModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    
    init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func build() -> UIViewController {
        let coordinator = HomeCoordinator(diContainer: diContainer)
        let viewModel = HomeViewModel(diContainer: diContainer)
        let controller = HomeViewController(viewModel: viewModel, coordinator: coordinator)
        coordinator.setupController(controller: controller)
        let shopVC = ShopModuleBuilder(diContainer: diContainer).build()
        let cartVC = CartModuleBuilder(diContainer: diContainer).build()
        let tabsControllers = [ shopVC, cartVC ]
        controller.viewControllers = tabsControllers
        return controller
    }
}
