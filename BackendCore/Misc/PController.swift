//
//  PController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection

public protocol PController: PHasDIContainer, PInitiableWithDIContainer {
    init(diContainer: PDIContainer)
    func registerRoutes(router: PRouteRegistrar) throws
}
