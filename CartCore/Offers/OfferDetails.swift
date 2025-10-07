//
//  OfferDetails.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import Foundation

public struct OfferDetails: Codable {
    public let offerId: UUID
    public let name: String
    public let price: Price
    public let unit: Unit
    public let availableUnits: Int
    public let description: String
    
    public init(offerId: UUID, name: String, price: Price, unit: Unit, availableUnits: Int, description: String) {
        self.offerId = offerId
        self.name = name
        self.price = price
        self.unit = unit
        self.availableUnits = availableUnits
        self.description = description
    }
}

public extension OfferDetails {
    func toOffer() -> Offer {
        return Offer(offerId: offerId, name: name, price: price, unit: unit, availableUnits: availableUnits)
    }
}
