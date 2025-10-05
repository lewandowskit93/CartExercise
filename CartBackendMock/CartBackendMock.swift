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
    try appBuilder.addService(ofType: CartService.self, asType: PCartService.self)
    appBuilder.addController(ofType: CartController.self)
    return try appBuilder.build()
}
