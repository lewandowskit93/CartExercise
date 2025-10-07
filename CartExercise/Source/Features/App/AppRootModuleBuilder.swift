//
//  AppRootModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import DependencyInjection

class AppRootModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    
    init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func build() -> UIViewController {
        let coordinator = AppRootCoordinator(diContainer: diContainer)
        let viewModel = AppViewModel(diContainer: diContainer)
        let controller = AppRootViewController(viewModel: viewModel, coordinator: coordinator)
        coordinator.setupController(controller: controller)
        return controller
    }
}
