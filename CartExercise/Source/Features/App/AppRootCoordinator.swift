//
//  AppRootCoordinator.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection
import UIKit

protocol PAppRootCoordinator {
    func openHome()
}

class AppRootCoordinator: PAppRootCoordinator {
    let diContainer: PDIContainer
    private weak var controller: AppRootViewController!

    required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    func setupController(controller: AppRootViewController) {
        self.controller = controller
    }
    
    func openHome() {
        let home = HomeModuleBuilder(diContainer: diContainer)
        let homeControler = home.build()
        controller.addChild(homeControler)
        controller.view.addSubview(homeControler.view)
        homeControler.didMove(toParent: controller)
        homeControler.view.pinToParent()
    }
}
