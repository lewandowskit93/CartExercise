//
//  PCurrenciesService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import RxSwift

public protocol PCurrenciesService: CartCore.PCurrenciesService {
    var currentCurrencyObservable: Observable<Currency> { get }
    var availableCurrenciesObservable: Observable<[Currency]> { get }

    func pickCurrency(currency: Currency)
}
