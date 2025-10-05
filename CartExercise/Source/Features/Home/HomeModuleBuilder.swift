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
        let controller = HomeViewController(coordinator: coordinator)
        coordinator.setupController(controller: controller)
        return controller
    }
}
