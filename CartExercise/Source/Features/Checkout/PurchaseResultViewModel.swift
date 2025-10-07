//
//  PurchaseResultViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import DependencyInjection
import RxSwift

protocol PPurchaseResultViewModel {
    var titleObservable: Observable<String> { get }
    var messageObservable: Observable<String> { get }
}

class PurchaseResultViewModel: PPurchaseResultViewModel, PHasDIContainer, PInitiableWithDIContainer {
    let diContainer: any DependencyInjection.PDIContainer
    
    let titleObservable = Observable.just("Success")
    let messageObservable = Observable.just("Items bought successfuly!")
    
    required init(diContainer: DependencyInjection.PDIContainer) {
        self.diContainer = diContainer
    }
}
