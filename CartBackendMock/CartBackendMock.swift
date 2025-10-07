//
//  CartBackendMock.swift
//  CartBackendMock
//
//  Created by Tomasz Lewandowski on 02/10/2025.
//

import Foundation
import BackendCore
internal import NetworkingCore
import CartCore

public func createBackendMock() throws -> PBackendApp {
    var appBuilder = BackendAppBuilder()
    appBuilder.setConfiguration(configuration: BasicBackendConfiguration(defaultResponseContentType: ContentTypes.applicationJson))
    appBuilder.setContentDecoder(decoder: JSONDecoder())
    appBuilder.setContentEncoder(encoder: JSONEncoder())
    try appBuilder.addService(ofType: OffersRepository.self, asType: POffersRepository.self)
    try appBuilder.addService(ofType: CartRepository.self, asType: PCartRepository.self)
    try appBuilder.addService(ofType: CurrenciesRepository.self, asType: PCurrenciesRepository.self)
    try appBuilder.addService(ofType: OffersService.self, asType: POffersService.self)
    try appBuilder.addService(ofType: CartService.self, asType: PCartService.self)
    try appBuilder.addService(ofType: CurrenciesService.self, asType: PCurrenciesService.self)
    appBuilder.addController(ofType: OffersController.self)
    appBuilder.addController(ofType: CartController.self)
    appBuilder.addController(ofType: CurrenciesController.self)
    return try appBuilder.build()
}
