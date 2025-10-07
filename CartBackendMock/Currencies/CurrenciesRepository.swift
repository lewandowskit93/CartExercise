//
//  CurrenciesRepository.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import DependencyInjection
import Foundation

public protocol PCurrenciesRepository {
    func getAllCurrencies() async throws -> [Currency]
    func getConversionRateConfiguration(fromCurrency: Currency, toCurrency: Currency) async throws -> ConversionRateConfiguration?
    func addConversionRateConfigurations(configurations: [ConversionRateConfiguration])
    func addConversionRateConfiguration(configuration: ConversionRateConfiguration)
}

public class CurrenciesRepository: PCurrenciesRepository, PInitiable {
    private let currencies: [Currency]
    private var conversionRates: [ConversionRateConfigurationKey:  ConversionRateConfiguration]
    private let usdConversionRatesSource = """
{
    "success": true,
    "timestamp": 1430401802,
    "source": "USD",
    "quotes": {
        "USDAED": 3.672982,
        "USDAFN": 57.8936,
        "USDALL": 126.1652,
        "USDAMD": 475.306,
        "USDANG": 1.78952,
        "USDAOA": 109.216875,
        "USDARS": 8.901966,
        "USDAUD": 1.269072,
        "USDAWG": 1.792375,
        "USDAZN": 1.04945,
        "USDBAM": 1.757305,
    }
}
"""
    
    public required init() {
        currencies = [.USD, .PLN, .EUR, .AED, .AFN, .ALL, .AMD, .ANG, .AOA, .ARS, .AUD, .AWG, .AZN, .BAM]
        conversionRates = [:]
        loadProvidedConversionRates()
        addConversionRateConfiguration(configuration: ConversionRateConfiguration(fromCurrency: .USD, toCurrency: .PLN, rate: 3.63))
        addConversionRateConfiguration(configuration: ConversionRateConfiguration(fromCurrency: .USD, toCurrency: .EUR, rate: 0.85))
        addConversionRateConfiguration(configuration: ConversionRateConfiguration(fromCurrency: .USD, toCurrency: .USD, rate: 1.0))
    }
    
    public func getAllCurrencies() async throws -> [CartCore.Currency] {
        return currencies
    }
    
    public func getConversionRateConfiguration(fromCurrency: Currency, toCurrency: Currency) async throws -> ConversionRateConfiguration? {
        let key = ConversionRateConfigurationKey(fromCurrency: fromCurrency, toCurrency: toCurrency)
        return conversionRates[key]
    }
    
    public func addConversionRateConfigurations(configurations: [ConversionRateConfiguration]) {
        for configuration in configurations {
            addConversionRateConfiguration(configuration: configuration)
        }
    }
    
    public func addConversionRateConfiguration(configuration: ConversionRateConfiguration) {
        let inverse = configuration.inverse()
        conversionRates[configuration.key()] = configuration
        conversionRates[inverse.key()] = inverse

    }

    
    private func loadProvidedConversionRates() {
        let data = Data(usdConversionRatesSource.utf8)
        let providedRates = try! JSONDecoder().decode(ProvidedConversionRates.self, from: data)
        var configurations = providedRates.quotes.map { k, v in ConversionRateConfiguration(fromCurrency: k.fromCurrency, toCurrency: k.toCurrency, rate: v) }
        addConversionRateConfigurations(configurations: configurations)
    }
}
