//
//  PBackendAppBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore
import DependencyInjection

public protocol PBackendAppBuilder {
    func addController<T>(ofType type: T.Type) where T: PController
    func addService<T>(ofType type: T.Type) where T: PInitiable
    func addService<T, TA>(ofType type: T.Type, asType: TA.Type) throws where T: PInitiable
    func addService<T>(ofType type: T.Type) where T: PInitiableWithDIContainer
    func addService<T, TA>(ofType type: T.Type, asType: TA.Type) throws where T: PInitiableWithDIContainer
    func addMiddleware<T>(ofType type: T.Type) where T: PMiddleware & PInitiable
    func addMiddleware<T>(ofType type: T.Type) where T: PMiddleware & PInitiableWithDIContainer
    func setConfiguration(configuration: PBackendConfiguration)
    func setContentEncoder(encoder: PContentEncoder)
    func setContentDecoder(decoder: PContentDecoder)
    func build() throws -> PBackendApp
}
