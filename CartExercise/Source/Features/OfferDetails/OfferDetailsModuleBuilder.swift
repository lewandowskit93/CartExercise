//
//  OfferDetailsModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import UIKit
import CartCore

class OfferDetailsModuleBuilder: PAppModuleBuilder {
    let diContainer: PDIContainer
    let offer: Offer
    
    init(diContainer: PDIContainer, offer: Offer) {
        self.diContainer = diContainer
        self.offer = offer
    }
    
    func build() -> UIViewController {
        let viewModel = OfferDetailsViewModel(diContainer: diContainer, offer: offer)
        let controller = OfferDetailsViewController(viewModel: viewModel)
        controller.navigationItem.title = "Offer details"
        return controller
    }
}
