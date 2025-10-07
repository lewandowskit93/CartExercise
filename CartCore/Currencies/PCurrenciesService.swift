//
//  PCurrenciesService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

public protocol PCurrenciesService {
    func getAvailableCurrencies() async throws -> [Currency]
    func getConversionRate(fromCurrency: Currency, toCurrency: Currency) async throws -> Double
}
