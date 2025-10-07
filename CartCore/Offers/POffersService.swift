//
//  POffersService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import Foundation

public protocol POffersService {
    func getAllOffers() async throws -> [Offer]
    func getOffers(offerIds: [UUID]) async throws -> [Offer]
    func getOfferDetails(offerId: UUID) async throws -> OfferDetails
}
