//
//  Offer.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import Foundation

public struct Offer: Codable {
    public let offerId: UUID
    public let name: String
    public let price: Price
    public let unit: Unit
    public let availableUnits: Int
    
    public init(offerId: UUID, name: String, price: Price, unit: Unit, availableUnits: Int) {
        self.offerId = offerId
        self.name = name
        self.price = price
        self.unit = unit
        self.availableUnits = availableUnits
    }
}
