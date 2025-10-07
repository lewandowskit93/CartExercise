//
//  OffersController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import CartCore
import DependencyInjection
import BackendCore
import Foundation
internal import NetworkingCore

public class OffersController: PController, PHasDIContainer {
    public let diContainer: PDIContainer

    @Inject(.enclosingInstance)
    private var offersService: POffersService
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getAllOffers() async throws -> [Offer] {
        let offers = try await offersService.getAllOffers()
        return offers
    }
    
    public func getOffersWithIds(offerIds: [UUID], requestContext: RequestContext) async throws -> [Offer] {
        let offers = try await offersService.getOffers(offerIds: offerIds)
        return offers
    }
    
    public func getOfferDetails(offerId: UUID, requestContext: RequestContext) async throws -> OfferDetails {
        let offer = try await offersService.getOfferDetails(offerId: offerId)
        return offer
    }
    
    public func registerRoutes(router: PRouteRegistrar) throws {
        try router.registerRoute(
            path: "/offers",
            method: .get,
            allowsEmptyRequestContent: true,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: getAllOffers
        )
        try router.registerRoute(
            path: "/offers/list",
            method: .get,
            allowsEmptyRequestContent: false,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: getOffersWithIds
        )
        try router.registerRoute(
            path: "/offers/details",
            method: .get,
            allowsEmptyRequestContent: false,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: getOfferDetails
        )
    }
}
