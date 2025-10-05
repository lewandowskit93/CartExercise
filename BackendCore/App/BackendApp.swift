//
//  BackendApp.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore
import DependencyInjection

public class BackendApp: PBackendApp {
    private let diContainer: DIContainer
    private let controllers: [PController]
    private let middlewares: [PMiddleware]
    private let router: PRouter
    
    public init(diContainer: DIContainer, controllers: [PController], middlewares: [PMiddleware], router: PRouter) {
        self.diContainer = diContainer
        self.controllers = controllers
        self.middlewares = middlewares
        self.router = router
    }
    
    public func handle(request: HttpRequest) async -> HttpResponse {
        let context = RequestContext(request: request)
        do {
            try router.route(context: context)
            let middlewares = self.middlewares // may add route middlewares to these
            try await callMiddlewareOrRouter(context: context, middlewares: middlewares, middlewareIndex: 0)
            return context.response! // set by callRouter
        }
        catch ContentDecodingError.unsupportedContentType {
            return HttpResponse(statusCode: .unsupportedMediaType)
        }
        catch ContentDecodingError.unsupporedType {
            return HttpResponse(statusCode: .badRequest)
        }
        catch ContentDecodingError.emptyPayload {
            return HttpResponse(statusCode: .badRequest)
        }
        catch ContentDecodingError.unknownContentType {
            return HttpResponse(statusCode: .badRequest)
        }
        catch RoutingError.routeNotFound {
            return HttpResponse(statusCode: .notFound)
        }
        catch {
            return HttpResponse(statusCode: .internalServerError)
        }
    }
    
    private func callMiddlewareOrRouter(context: RequestContext, middlewares: [PMiddleware], middlewareIndex: Int) async throws {
        if(middlewareIndex < middlewares.count) {
            let middleware = middlewares[middlewareIndex]
            try await middleware(requestContext: context, next: { [unowned self] in
                try await self.callMiddlewareOrRouter(context: context, middlewares: middlewares, middlewareIndex: middlewareIndex+1)
            })
        } else {
            try await self.callRouter(context: context)
        }
    }
    
    private func callRouter(context: RequestContext) async throws {
        do {
            let response = try await context.route?.handle(context)
            context.response = response
        }
        catch ContentDecodingError.unsupportedContentType {
            context.response = HttpResponse(statusCode: .unsupportedMediaType)
        }
        catch ContentDecodingError.unsupporedType {
            context.response = HttpResponse(statusCode: .badRequest)
        }
        catch ContentDecodingError.emptyPayload {
            context.response = HttpResponse(statusCode: .badRequest)
        }
        catch ContentDecodingError.unknownContentType {
            context.response = HttpResponse(statusCode: .badRequest)
        }
        catch {
            context.response = HttpResponse(statusCode: .internalServerError)
        }
    }
}
