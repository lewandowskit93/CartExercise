//
//  ProvidedConversionRates.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore

public struct ProvidedConversionRates: Decodable {
    enum CodingKeys: CodingKey {
        case success
        case timestamp
        case source
        case quotes
    }
    let success: Bool
    let timestamp: Int
    let source: Currency
    let quotes: Dictionary<ConversionRateConfigurationKey, Double>
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.timestamp = try container.decode(Int.self, forKey: .timestamp)
        self.source = try container.decode(Currency.self, forKey: .source)
        let quotes = try container.decode([String : Double].self, forKey: .quotes)
        let quotesPairs = quotes.map { k, v in
            let fromCurrencyRaw = String(k[k.startIndex..<k.index(k.startIndex, offsetBy: 3)])
            let toCurrencyRaw = String(k[k.index(k.startIndex, offsetBy: 3)..<k.endIndex])
            let fromCurrency = Currency(rawValue: fromCurrencyRaw)!
            let toCurrency = Currency(rawValue: toCurrencyRaw)!
            let currencyKey = ConversionRateConfigurationKey(fromCurrency: fromCurrency, toCurrency: toCurrency)
            return (currencyKey, v)
        }
        self.quotes = Dictionary(uniqueKeysWithValues: quotesPairs)
    }
}

