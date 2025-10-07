//
//  OffersService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import CartCore
import Foundation
import DependencyInjection

public class OffersService: POffersService, PInitiableWithDIContainer, PHasDIContainer {
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var repository: POffersRepository

    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getAllOffers() async throws -> [CartCore.Offer] {
        return try await repository.getAllOffers()
    }
    
    public func getOffers(offerIds: [UUID]) async throws -> [CartCore.Offer] {
        return try await repository.getOffers(offerIds: offerIds)
    }
    
    public func getOfferDetails(offerId: UUID) async throws -> CartCore.OfferDetails {
        return try await repository.getOfferDetails(offerId: offerId)
    }
}
