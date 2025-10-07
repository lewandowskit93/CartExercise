//
//  ConversionRateRequest.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

public struct ConversionRateRequest: Codable {
    public let fromCurrency: Currency
    public let toCurrency: Currency
    
    public init(fromCurrency: Currency, toCurrency: Currency) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }
}
