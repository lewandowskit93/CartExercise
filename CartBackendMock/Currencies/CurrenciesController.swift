//
//  CurrenciesController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import CartCore
import DependencyInjection
import BackendCore
internal import NetworkingCore

public class CurrenciesController: PController, PHasDIContainer {
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var currenciesService: PCurrenciesService
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func getAvailableCurrencies() async throws -> [Currency] {
        let currencies = try await currenciesService.getAvailableCurrencies()
        return currencies
    }
    
    public func getConversionRate(conversionRateRequest: ConversionRateRequest, requestContext: RequestContext) async throws -> Double {
        let rate = try await currenciesService.getConversionRate(fromCurrency: conversionRateRequest.fromCurrency, toCurrency: conversionRateRequest.toCurrency)
        return rate
    }
    
    
    public func registerRoutes(router: any BackendCore.PRouteRegistrar) throws {
        try router.registerRoute(
            path: "/currencies",
            method: .get,
            allowsEmptyRequestContent: true,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: getAvailableCurrencies
        )
        try router.registerRoute(
            path: "/currencies/conversion-rate",
            method: .get,
            allowsEmptyRequestContent: false,
            allowsEmptyResponseContent: false,
            acceptedContentTypes: nil, // will take supported by default
            responseContentTypes: nil, // will take supported by default
            handler: getConversionRate
        )
    }
}
