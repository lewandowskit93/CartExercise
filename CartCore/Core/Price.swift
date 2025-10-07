//
//  Price.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

public struct Price: Codable {
    public let value: Double
    public let currency: Currency
    
    public init(value: Double, currency: Currency) {
        self.value = value
        self.currency = currency
    }
}
