//
//  CurrenciesService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import DependencyInjection
import HttpClient
import RxSwift

public class CurrenciesService: PCurrenciesService, PInitiableWithDIContainer, PHasDIContainer {
    
    public var currentCurrencyObservable: Observable<Currency> { currentCurrencySubject }
    public var availableCurrenciesObservable: Observable<[Currency]> { availableCurrenciesSubject }
    private let currentCurrencySubject: BehaviorSubject<Currency>
    private let availableCurrenciesSubject: BehaviorSubject<[Currency]>

    
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var apiClient: PAuthorizedCartClient
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
        currentCurrencySubject = BehaviorSubject(value: Currency.USD)
        availableCurrenciesSubject =  BehaviorSubject(value: [])
        Task {
            try await getAvailableCurrencies()
        }
    }
    
    public func pickCurrency(currency: Currency) {
        currentCurrencySubject.onNext(currency)
    }
    
    public func getAvailableCurrencies() async throws -> [Currency] {
        let currencies: [Currency] = try await apiClient.get(path: "/currencies")
        availableCurrenciesSubject.onNext(currencies)
        return currencies
    }
    
    public func getConversionRate(fromCurrency: Currency, toCurrency: Currency) async throws -> Double {
        let requestPayload = ConversionRateRequest(fromCurrency: fromCurrency, toCurrency: toCurrency)
        let conversionRate: Double = try await apiClient.get(path: "/currencies/conversion-rate", payload: requestPayload)
        return conversionRate

    }
}
