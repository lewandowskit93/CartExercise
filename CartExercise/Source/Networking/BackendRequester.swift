//
//  BackendRequester.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection
import HttpClient
import BackendCore
import NetworkingCore


class BackendRequester: PInitiableWithDIContainer, PHasDIContainer, PHttpRequester {
    
    public let diContainer: any DependencyInjection.PDIContainer
    
    @Inject(.enclosingInstance)
    private var backend: PBackendApp
    
    public required init(diContainer: any DependencyInjection.PDIContainer) {
        self.diContainer = diContainer
    }
    
    public func send(request: NetworkingCore.HttpRequest) async throws -> NetworkingCore.HttpResponse {
        return await backend.handle(request: request)
    }
}
