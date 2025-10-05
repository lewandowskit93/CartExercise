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
        let viewModel = CartViewModel(diContainer: diContainer)
        let controller = CartViewController(viewModel: viewModel)
        return controller
    }
}
