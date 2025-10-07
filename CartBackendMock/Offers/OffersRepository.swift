//
//  OffersRepository.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import Foundation
import CartCore
import DependencyInjection

public protocol POffersRepository {
    func getAllOffers() async throws -> [Offer]
    func getOffers(offerIds: [UUID]) async throws -> [Offer]
    func getOfferDetails(offerId: UUID) async throws -> OfferDetails
}

public class OffersRepository: POffersRepository, PInitiable {
    private var offers: Dictionary<UUID, OfferDetails>
    
    public required init() {
        offers = [:]
        addOffers(
            [
                OfferDetails(
                    offerId: UUID(),
                    name: "Potato",
                    price: Price(value: 0.95, currency: .USD),
                    unit: .bag,
                    availableUnits: 1000,
                    description: "Tasty bananas from Columbia"
                ),
                OfferDetails(
                    offerId: UUID(),
                    name: "Eggs",
                    price: Price(value: 2.10, currency: .USD),
                    unit: .dozen,
                    availableUnits: 500,
                    description: "Organic barn eggs from laying hens"
                ),
                OfferDetails(
                    offerId: UUID(),
                    name: "Milk",
                    price: Price(value: 1.30, currency: .USD),
                    unit: .bottle,
                    availableUnits: 250,
                    description: "Milk 3,2% from Alpine Cows"
                ),
                OfferDetails(
                    offerId: UUID(),
                    name: "Banana",
                    price: Price(value: 0.73, currency: .USD),
                    unit: .kg,
                    availableUnits: 1000,
                    description: "Tasty bananas from Columbia"
                ),
                OfferDetails(
                    offerId: UUID(),
                    name: "Computer",
                    price: Price(value: 2000.0, currency: .USD),
                    unit: .unit,
                    availableUnits: 5,
                    description: """
Super computer
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas molestie nisi quis lacus volutpat interdum. Fusce sed ipsum venenatis, ornare ex et, iaculis lacus. Nulla dui augue, pretium semper purus id, fringilla dictum mauris. Mauris lobortis libero quis iaculis euismod. Quisque nec nibh mollis, cursus nibh vel, commodo tortor. Suspendisse fermentum, lectus et tincidunt lacinia, ex leo faucibus nibh, eu faucibus metus tellus vitae ante. Proin non erat eget turpis porta consectetur. Nulla vel dolor nisl. Morbi vitae mollis mauris, non pretium lacus. In eleifend vestibulum dignissim. Maecenas ac venenatis neque. Nullam auctor pharetra venenatis. Sed condimentum commodo dui vitae dignissim.

Nam tincidunt ornare accumsan. Pellentesque et lacus rhoncus arcu auctor egestas. Proin id lacinia enim. Nulla eleifend ex at tristique gravida. Nulla facilisi. Donec enim purus, pharetra id arcu tincidunt, pulvinar imperdiet sem. Nulla nunc nunc, volutpat at ex et, interdum congue nunc. Vestibulum consectetur, dui in lobortis hendrerit, ante justo vestibulum sapien, vitae interdum diam purus in magna. Cras eu tellus convallis, laoreet dolor in, scelerisque urna. Donec eleifend venenatis varius.

Donec blandit nulla vel elit tempus pulvinar. Ut eget justo dolor. Quisque consectetur diam vel sapien tristique, non rhoncus lorem tempus. Pellentesque ac lectus ligula. Mauris vestibulum tincidunt est, a porttitor ligula faucibus vitae. Maecenas iaculis nibh diam, pretium hendrerit nisl euismod sit amet. Cras rutrum convallis est nec vehicula. Nam et lacus sit amet diam vulputate ullamcorper sed quis tellus. Proin diam neque, lacinia id metus quis, porttitor tincidunt sapien. Cras cursus egestas libero sit amet faucibus. Morbi sed mauris erat.
"""
                ),
            ]
        )
    }
    
    public func getAllOffers() async throws -> [Offer] {
        return offers.values.map { $0.toOffer() }
    }
    
    public func getOffers(offerIds: [UUID]) async throws -> [Offer] {
        let offerIdsSet = Set(offerIds)
        return offers.values
            .filter { offerIdsSet.contains($0.offerId) }
            .map{ $0.toOffer() }
    }
    
    public func getOfferDetails(offerId: UUID) -> OfferDetails {
        return offers[offerId]!
    }
    
    private func addOffers(_ offers: [OfferDetails]) {
        for offer in offers {
            addOffer(offer)
        }
    }
    
    private func addOffer(_ offer: OfferDetails) {
        offers[offer.offerId] = offer
    }
}
