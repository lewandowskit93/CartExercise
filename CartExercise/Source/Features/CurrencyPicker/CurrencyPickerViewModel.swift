//
//  CurrencyPickerViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import RxSwift

protocol PCurrencyPickerViewModel {
    var currentCurrency: Currency { get }
    var availableCurrencies: [Currency] { get }
    var onPickedCurrencySubject: PublishSubject<Currency> { get }
}

class CurrencyPickerViewModel: PCurrencyPickerViewModel {
    let onPickedCurrencySubject = PublishSubject<Currency>()
    let availableCurrencies: [Currency]
    let currentCurrency: Currency


    init(currentCurrency: Currency, availableCurrencies: [Currency]) {
        self.currentCurrency = currentCurrency
        self.availableCurrencies = availableCurrencies
    }
}
