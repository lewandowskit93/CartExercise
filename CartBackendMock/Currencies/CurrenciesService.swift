//
//  CurrenciesService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import Foundation
import DependencyInjection

public class CurrenciesService: PCurrenciesService, PInitiableWithDIContainer, PHasDIContainer {
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var repository: PCurrenciesRepository
    @Inject(.enclosingInstance)
    private var offersService: POffersService

    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getAvailableCurrencies() async throws -> [CartCore.Currency] {
        return try await repository.getAllCurrencies()
    }
    
    public func getConversionRate(fromCurrency: CartCore.Currency, toCurrency: CartCore.Currency) async throws -> Double {
        let directConfiguration = try? await repository.getConversionRateConfiguration(fromCurrency: fromCurrency, toCurrency: toCurrency)
        if let directConfiguration = directConfiguration {
            return directConfiguration.rate
        }
        let fromCurrencyToUSDConfiguration = try! await repository.getConversionRateConfiguration(fromCurrency: fromCurrency, toCurrency: .USD)!
        let fromUSDToTargetCurrencyConfiguration = try! await  repository.getConversionRateConfiguration(fromCurrency: .USD, toCurrency: toCurrency)!
        let newConfiguration = ConversionRateConfiguration(fromCurrency: fromCurrency, toCurrency: toCurrency, rate: fromCurrencyToUSDConfiguration.rate * fromUSDToTargetCurrencyConfiguration.rate)
        repository.addConversionRateConfiguration(configuration: newConfiguration)
        return newConfiguration.rate
    }
}
