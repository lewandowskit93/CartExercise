//
//  ConversionRateConfigurationKey.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore

public struct ConversionRateConfigurationKey: Hashable {
    public let fromCurrency: Currency
    public let toCurrency: Currency
    
    public init(fromCurrency: Currency, toCurrency: Currency) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }
}
