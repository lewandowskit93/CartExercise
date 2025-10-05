//
//  BackendAppBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection
import NetworkingCore



public class BackendAppBuilder: PBackendAppBuilder, PRouteRegistrar {
    typealias RegisterToRouterFunc = (PRouteRegistrar) throws -> Void
    
    private let diContainer: DIContainer
    // delayed factories and registrars, so that all dependencies are setup first and then rest is resolved while building
    private var controllerFactories: [PControllerFactoryFunc]
    private var middlewareFactories: [PMiddlewareFactoryFunc]
    private var registerRouteFuncs: [RegisterToRouterFunc]
    
    public init() {
        diContainer = DIContainer()
        controllerFactories = []
        middlewareFactories = []
        registerRouteFuncs = []
    }
    
    public func addController<T>(ofType type: T.Type) where T : PController {
        let container = diContainer
        controllerFactories.append {
            let controller = T.init(diContainer: container)
            return controller
        }
    }
    
    public func addService<T>(ofType type: T.Type) where T : DependencyInjection.PInitiable {
        diContainer.registerLazySingleton(factory: { container in
            let service = T.init()
            return service
        })
    }
    
    public func addService<T>(ofType type: T.Type) where T : DependencyInjection.PInitiableWithDIContainer {
        diContainer.registerLazySingleton(factory: { container in
            let service = T.init(diContainer: container)
            return service
        })
    }
    
    public func addService<T, TA>(ofType type: T.Type, asType: TA.Type) throws where T : DependencyInjection.PInitiableWithDIContainer {
        try diContainer.registerLazySingleton(as: asType, factory: { container in
            let service = T.init(diContainer: container)
            return service
        })
    }
    
    public func addService<T, TA>(ofType type: T.Type, asType: TA.Type) throws where T : DependencyInjection.PInitiable {
        try diContainer.registerLazySingleton(as: asType, factory: { container in
            let service = T.init()
            return service
        })
    }
    
    public func addMiddleware<T>(ofType type: T.Type) where T : PMiddleware, T : DependencyInjection.PInitiable {
        middlewareFactories.append {
            let middleware = T.init()
            return middleware
        }
    }

    public func addMiddleware<T>(ofType type: T.Type) where T : PMiddleware, T : DependencyInjection.PInitiableWithDIContainer {
        let container = diContainer
        middlewareFactories.append {
            let middleware = T.init(diContainer: container)
            return middleware
        }
    }
    
    public func setConfiguration(configuration: PBackendConfiguration) {
        diContainer.registerSingleton(item: configuration)
    }
    
    public func setContentEncoder(encoder: PContentEncoder) {
        diContainer.registerSingleton(item: encoder)

    }
    
    public func setContentDecoder(decoder: PContentDecoder) {
        diContainer.registerSingleton(item: decoder)
    }
    
    public func registerRoute(route: any PRoute) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(route: route)
        }
    }
    
    public func registerRoute(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping () async throws -> Void) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping () async throws -> NetworkingCore.HttpResponse) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute<ResponseModel: Encodable>(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping () async throws -> ResponseModel) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> Void) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> NetworkingCore.HttpResponse) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute<ResponseModel: Encodable>(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> ResponseModel) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (NetworkingCore.HttpRequest, RequestContext) async throws -> Void) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (NetworkingCore.HttpRequest, RequestContext) async throws -> NetworkingCore.HttpResponse) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute<ResponseModel: Encodable>(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (NetworkingCore.HttpRequest, RequestContext) async throws -> ResponseModel) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute<RequestModel: Decodable>(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (RequestModel, RequestContext) async throws -> Void) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute<RequestModel: Decodable>(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (RequestModel, RequestContext) async throws -> NetworkingCore.HttpResponse) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    public func registerRoute<RequestModel: Decodable, ResponseModel: Encodable>(path: String, method: NetworkingCore.HttpMethod, allowsEmptyRequestContent: Bool, allowsEmptyResponseContent: Bool, acceptedContentTypes: Set<String>?, responseContentTypes: Set<String>?, handler: nonisolated(nonsending) @escaping (RequestModel, RequestContext) async throws -> ResponseModel) throws {
        registerRouteFuncs.append { registrar in
            try registrar.registerRoute(path: path, method: method, allowsEmptyRequestContent: allowsEmptyRequestContent, allowsEmptyResponseContent: allowsEmptyResponseContent, acceptedContentTypes: acceptedContentTypes, responseContentTypes: responseContentTypes, handler: handler)
        }
    }
    
    // to build an app setDecoder and setConfiguraton has to be called first
    public func build() throws -> any PBackendApp {
        let controllers = try controllerFactories.map { try $0() }
        let middlewares = try middlewareFactories.map { try $0() }
        let router = Router(diContainer: diContainer)
        for registerFunc in registerRouteFuncs {
            try registerFunc(router)
        }
        for controller in controllers {
            try controller.registerRoutes(router: router)
        }
        let backendApp = BackendApp(diContainer: diContainer, controllers: controllers, middlewares: middlewares, router: router)
        return backendApp
    }
}
