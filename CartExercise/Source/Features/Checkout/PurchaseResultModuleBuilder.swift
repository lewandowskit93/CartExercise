//
//  PurchaseResultModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import DependencyInjection
import UIKit

class PurchaseResultModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    let coordinator: PCheckoutCoordinator
    
    init(diContainer: PDIContainer, coordinator: PCheckoutCoordinator) {
        self.diContainer = diContainer
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = PurchaseResultViewModel(diContainer: diContainer)
        let controller = PurchaseResultViewController(viewModel: viewModel, coordinator: coordinator)
        controller.navigationItem.title = "Success"
        return controller
    }
}
