//
//  CartViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import RxSwift
import DependencyInjection
import CartSDK
import CartCore

protocol PCartViewModel {
    var cardIdObservable: Observable<String> { get }
    
    func onViewLoaded()
}

struct CartViewModel: PCartViewModel, PHasDIContainer, PInitiableWithDIContainer {
    let diContainer: any DependencyInjection.PDIContainer
    
    @Inject(.fixed(DepsContainers.cartApp))
    private var cartService: CartSDK.PCartService
    
    init(diContainer: DependencyInjection.PDIContainer) {
        self.diContainer = diContainer
    }
    
    var cardIdObservable: Observable<String> { cartService.cartObservable.map { $0.cartId.uuidString } }
    
    func onViewLoaded() {
        cartService.loadCart()
    }
}

