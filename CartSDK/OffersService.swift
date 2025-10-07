//
//  OffersService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import CartCore
import DependencyInjection
import HttpClient
import RxSwift

public class OffersService: POffersService, PInitiableWithDIContainer, PHasDIContainer {
    
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var apiClient: PUnauthorizedCartClient
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getAllOffers() async throws -> [CartCore.Offer] {
        let offers: [Offer] = try await apiClient.get(path: "/offers")
        return offers
    }
    
    public func getOffers(offerIds: [UUID]) async throws -> [CartCore.Offer] {
        let offers: [Offer] = try await apiClient.get(path: "/offers/list", payload: offerIds)
        return offers
    }
    
    public func getOfferDetails(offerId: UUID) async throws -> CartCore.OfferDetails {
        let offers: OfferDetails = try await apiClient.get(path: "/offers/details", payload: offerId)
        return offers
    }
}
