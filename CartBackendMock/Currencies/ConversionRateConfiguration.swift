//
//  ConversionRateConfiguration.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore

public struct ConversionRateConfiguration {
    public let fromCurrency: Currency
    public let toCurrency: Currency
    public let rate: Double
    
    public init(fromCurrency: Currency, toCurrency: Currency, rate: Double) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.rate = rate
    }
    
    func inverse() -> ConversionRateConfiguration {
        return ConversionRateConfiguration(fromCurrency: toCurrency, toCurrency: fromCurrency, rate: 1.0/rate)
    }
    
    func key() -> ConversionRateConfigurationKey {
        return ConversionRateConfigurationKey(fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
}

