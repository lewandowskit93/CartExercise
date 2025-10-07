//
//  CheckoutCoordinator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import UIKit

protocol PCheckoutCoordinator {
    func goToResult()
    func finishFlow()
}

class CheckoutCoordinator: PCheckoutCoordinator {
    let diContainer: PDIContainer
    private weak var controller: CheckoutViewController!

    required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func setupController(controller: CheckoutViewController) {
        self.controller = controller
        
    }
    
    func goToResult() {
        let vc = PurchaseResultModuleBuilder(diContainer: diContainer, coordinator: self).build()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func finishFlow() {
        controller?.navigationController?.popToRootViewController(animated: true)
    }
}
