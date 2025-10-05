//
//  Router.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import DependencyInjection
import NetworkingCore

public class Router: PRouteRegistrar, PRouter, PHasDIContainer, PInitiableWithDIContainer {
    private struct RouteKey: Equatable, Hashable {
        public let path: String
        public let method: HttpMethod
    }
    
    @Inject(.enclosingInstance)
    private var backendConfiguration: PBackendConfiguration
    @Inject(.enclosingInstance)
    private var responsePayloadEncoder: PContentEncoder
    @Inject(.enclosingInstance)
    private var requestPayloadDecoder: PContentDecoder

    public let diContainer: PDIContainer
    
    private var routes: Dictionary<RouteKey, PRoute>
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
        self.routes = Dictionary<RouteKey, PRoute>()
    }
    
    public func route(context: RequestContext) throws {
        let routeKey = RouteKey(path: context.request.url, method: context.request.method)
        guard let route = routes[routeKey] else {
            throw RoutingError.routeNotFound(path: routeKey.path, method: routeKey.method)
        }
        context.route = route
    }
    
    public func registerRoute(route: PRoute) throws {
        let routeKey = RouteKey(path: route.path, method: route.method)
        guard !(routes.keys.contains(routeKey)) else {
            throw RouterSetupError.routeAlreadyDefined(path: routeKey.path, method: routeKey.method)
        }
        routes[routeKey] = route
    }
    
    public func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping () async throws -> Void) throws
    {
        let route = RouteNoRequestNoResponseWithoutContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping () async throws -> HttpResponse) throws
    {
        let route = RouteNoRequestRawResponseWithoutContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute<ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping () async throws -> ResponseModel) throws
    {
        let route = RouteNoRequestEncodedResponseWithoutContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            encoder: responsePayloadEncoder,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> Void) throws
    {
        let route = RouteNoRequestNoResponseWithContext (
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> HttpResponse) throws
    {
        let route = RouteNoRequestRawResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute<ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestContext) async throws -> ResponseModel) throws
    {
        let route = RouteNoRequestEncodedResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            encoder: responsePayloadEncoder,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (HttpRequest, RequestContext) async throws -> Void) throws
    {
        let route = RouteRawRequestNoResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (HttpRequest, RequestContext) async throws -> HttpResponse) throws
    {
        let route = RouteRawRequestRawResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute<ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (HttpRequest, RequestContext) async throws -> ResponseModel) throws
    {
        let route = RouteRawRequestEncodedResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            encoder: responsePayloadEncoder,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute<RequestModel: Decodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestModel, RequestContext) async throws -> Void) throws
    {
        let route = RouteEncodedRequestNoResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            decoder: requestPayloadDecoder,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute<RequestModel: Decodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestModel, RequestContext) async throws -> HttpResponse) throws
    {
        let route = RouteEncodedRequestRawResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            decoder: requestPayloadDecoder,
            handler: handler)
        try registerRoute(route: route)
    }
    
    public func registerRoute<RequestModel: Decodable, ResponseModel: Encodable>(
        path: String,
        method: HttpMethod,
        allowsEmptyRequestContent: Bool,
        allowsEmptyResponseContent: Bool,
        acceptedContentTypes: Set<String>?,
        responseContentTypes: Set<String>?,
        handler: nonisolated(nonsending) @escaping (RequestModel, RequestContext) async throws -> ResponseModel) throws
    {
        let route = RouteEncodedRequestEncodedResponseWithContext(
            path: path,
            method: method,
            allowsEmptyRequestContent: allowsEmptyRequestContent,
            allowsEmptyResponseContent: allowsEmptyResponseContent,
            acceptedContentTypes: acceptedContentTypes ?? requestPayloadDecoder.supportedContentTypes,
            responseContentTypes: responseContentTypes ?? responsePayloadEncoder.supportedContentTypes,
            encoder: responsePayloadEncoder,
            decoder: requestPayloadDecoder,
            handler: handler)
        try registerRoute(route: route)
    }
}
