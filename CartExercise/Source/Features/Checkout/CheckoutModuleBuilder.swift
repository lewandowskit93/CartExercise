//
//  CheckoutModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import UIKit

class CheckoutModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    let summary: CheckoutSummary
    
    init(diContainer: PDIContainer, summary: CheckoutSummary) {
        self.diContainer = diContainer
        self.summary = summary
    }
    
    func build() -> UIViewController {
        let coordinator = CheckoutCoordinator(diContainer: diContainer)
        let viewModel = CheckoutViewModel(diContainer: diContainer, coordinator: coordinator, checkoutSummary: summary)
        let controller = CheckoutViewController(viewModel: viewModel)
        coordinator.setupController(controller: controller)
        controller.navigationItem.title = "Checkout"
        return controller
    }
}
